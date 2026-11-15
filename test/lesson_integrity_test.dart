// Checks that every lesson in lesson_data.dart has its text, its quiz and all
// the audio it needs, for both scales, and that the Raag order is the agreed one.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gurlingo/data/lesson_data.dart';
import 'package:gurlingo/data/quiz_data.dart';
import 'package:gurlingo/data/raag_lesson_content.dart';
import 'package:gurlingo/data/sur_lesson_content.dart';
import 'package:gurlingo/services/lesson_audio_service.dart';

// Recordings the quizzes already point at but that have not been added yet.
// Remove an entry once its file is in assets/audio.
const pendingRecordings = <String>{};

bool _exists(String path) =>
    pendingRecordings.contains(path) || File(path).existsSync();

void main() {
  const scales = ['C#', 'G#'];

  test('Raag lessons are in the agreed order with sequential ids', () {
    expect(raagLessons.map((l) => l.title).toList(), [
      'What is a Raag?',
      'Raag Bilaval',
      'Raag Basant',
      'Raag Kalyan',
      'Raag Bhairo',
      'Raag Todi',
      'Raag Sarang',
      'Raag Gond',
      'Raag Malhar',
      'Sri Raag',
      'Raag Maru',
    ]);
    expect(raagLessons.map((l) => l.id).toList(),
        [for (var i = 1; i <= 11; i++) 'raag-$i']);
  });

  test('Every Raag lesson id points at the matching content', () {
    for (final lesson in raagLessons.skip(1)) {
      final content = raagLessonContents[lesson.id];
      expect(content, isNotNull, reason: lesson.id);
      expect(content!.name, lesson.title, reason: lesson.id);
    }
    expect(raagLessonContents['raag-1'], isNotNull);
    expect(raagLessonContents.length, raagLessons.length);
  });

  test('Every Sur / Vakrit lesson has content', () {
    for (final lesson in [...surLessons, ...vakritSurLessons]) {
      expect(SurLessonData.getLesson(lesson.id), isNotNull, reason: lesson.id);
    }
    expect(surLessons.length, 7);
    expect(vakritSurLessons.length, 5);
  });

  for (final scale in scales) {
    test('Every lesson has a valid quiz with existing audio ($scale)', () {
      final all = [...raagLessons, ...surLessons, ...vakritSurLessons];
      expect(all.length, 23);

      for (final lesson in all) {
        final questions = QuizData.getQuiz(lesson.id, scale: scale);
        expect(questions.length, 10, reason: '${lesson.id} should have 10');

        for (var i = 0; i < questions.length; i++) {
          final q = questions[i];
          final where = '${lesson.id} Q${i + 1}';
          expect(q.options.length, 4, reason: where);
          expect(q.answer, inInclusiveRange(0, 3), reason: where);

          if (q.type == 'audio_question') {
            expect(_exists(q.audioPath!), isTrue,
                reason: '$where missing ${q.audioPath}');
          }
          if (q.type == 'audio_options') {
            expect(q.options, ['Audio 1', 'Audio 2', 'Audio 3', 'Audio 4'],
                reason: where);
            expect(q.optionAudioPaths!.length, 4, reason: where);
            for (final p in q.optionAudioPaths!) {
              expect(_exists(p), isTrue, reason: '$where missing $p');
            }
          }
        }
      }
    });

    test('All lesson audio exists ($scale)', () {
      for (final content in raagLessonContents.values) {
        if (content.audioKey.isEmpty) continue;
        for (final avroh in [false, true]) {
          final p = LessonAudioService.raagAudioByKey(scale, content.audioKey,
              avroh: avroh);
          expect(_exists(p), isTrue, reason: p);
        }
        final v = LessonAudioService.surAudio(scale, content.vaadee);
        final s = LessonAudioService.surAudio(scale, content.samvaadee);
        expect(_exists(v), isTrue, reason: v);
        expect(_exists(s), isTrue, reason: s);
      }
      for (final lesson in SurLessonData.lessons) {
        for (final seq in lesson.practiceSequences) {
          final p = LessonAudioService.sargamAudio(scale, seq);
          expect(_exists(p), isTrue, reason: '${lesson.id} $seq $p');
        }
      }
    });
  }
}
