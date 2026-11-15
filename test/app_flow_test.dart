// End-to-end user flow: welcome -> sign up -> home (scale switch) -> a Sur
// lesson and quiz -> a Raag lesson and quiz (fail, retry, pass) -> progress
// and streak. Runs against the real app widgets with mocked storage and audio.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gurlingo/data/lesson_data.dart';
import 'package:gurlingo/data/quiz_data.dart';
import 'package:gurlingo/main.dart';
import 'package:gurlingo/services/app_state.dart';
import 'package:gurlingo/services/local_storage_service.dart';
import 'package:gurlingo/theme/app_theme.dart';
import 'package:gurlingo/widgets/lesson_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

Finder _inBottomBar(String label) => find.descendant(
      of: find.byType(BottomNavigationBar),
      matching: find.text(label),
    );

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Answers every question of lesson [id]: all right or all wrong.
/// Returns after the last "Continue" (the result screen is showing).
Future<void> _takeQuiz(
  WidgetTester tester,
  String id, {
  required bool correct,
  bool checkProgressBar = false,
}) async {
  final scale = AppState.currentUser!.preferredScale;
  final questions = QuizData.getQuiz(id, scale: scale);
  expect(questions.length, 10);

  for (var i = 0; i < questions.length; i++) {
    final q = questions[i];
    final pick = correct ? q.answer : (q.answer + 1) % q.options.length;
    await _tap(tester, find.text(q.options[pick]).last);
    await _tap(tester, find.text('Check Answer'));

    if (checkProgressBar) {
      // After checking question i+1 the bar shows (i+1)/10.
      final bar = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(bar.value, closeTo((i + 1) / questions.length, 0.001));
      expect(find.text('${i + 1}/10'), findsOneWidget);
    }
    await _tap(tester, find.text('Continue'));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTheme.useGoogleFonts = false;
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    for (final channel in const [
      'xyz.luan/audioplayers',
      'xyz.luan/audioplayers.global',
    ]) {
      messenger.setMockMethodCallHandler(MethodChannel(channel), (_) async => null);
    }
  });

  testWidgets('a new learner goes through the whole app', (tester) async {
    tester.view.physicalSize = const Size(600, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    SharedPreferences.setMockInitialValues({});
    AppState.currentUser = null;

    // ---- Welcome -> sign up ------------------------------------------------
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Get Started'), findsOneWidget);

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextField);
    expect(fields, findsNWidgets(3));
    await tester.enterText(fields.at(0), 'Test Learner');
    await tester.enterText(fields.at(1), 'learner@example.com');
    await tester.enterText(fields.at(2), 'secret123');
    await tester.tap(find.text('Create Account'));
    await tester.pumpAndSettle();

    // ---- Home dashboard -----------------------------------------------------
    expect(find.text('Welcome, Test Learner'), findsOneWidget);
    expect(AppState.currentUser!.streakDays, 0);
    expect(find.text('0/12'), findsOneWidget);
    expect(find.text('0/11'), findsOneWidget);

    // The account really was saved.
    final saved = await LocalStorageService.getUserProgress('learner@example.com');
    expect(saved, isNotNull);

    // Default scale is Male (C#); switch to Female (G#) and back.
    expect(AppState.currentUser!.preferredScale, 'C#');
    await tester.tap(find.text('Female Scale (G#)'));
    await tester.pumpAndSettle();
    expect(AppState.currentUser!.preferredScale, 'G#');
    await tester.tap(find.text('Male Scale (C#)'));
    await tester.pumpAndSettle();
    expect(AppState.currentUser!.preferredScale, 'C#');

    // Finish on the female scale so the quizzes use the G# recordings.
    await tester.tap(find.text('Female Scale (G#)'));
    await tester.pumpAndSettle();
    expect(AppState.currentUser!.preferredScale, 'G#');

    // ---- Sur lesson 1: read, audio buttons, quiz ---------------------------
    await tester.tap(_inBottomBar('Sur'));
    await tester.pumpAndSettle();
    expect(find.text('Shudh Sur Recognition'), findsOneWidget);

    final sur1 = surLessons.first;
    await _tap(tester, find.text(sur1.title));
    expect(tester.takeException(), isNull);
    await tester.scrollUntilVisible(find.text('Practice'), 300);
    expect(find.text('Practice'), findsOneWidget);
    expect(find.text('Scale: G#'), findsOneWidget);
    expect(find.byType(AudioPlayButton), findsWidgets);
    expect(find.text('Start Quiz'), findsOneWidget);

    // Play and stop one clip from the lesson.
    await tester.ensureVisible(find.byIcon(Icons.play_arrow_rounded).first);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.play_arrow_rounded).first);
    await tester.pump();
    expect(find.byIcon(Icons.stop_rounded), findsOneWidget);
    await tester.tap(find.byIcon(Icons.stop_rounded));
    await tester.pump();

    await _tap(tester, find.text('Start Quiz'));
    await _takeQuiz(tester, sur1.id, correct: true, checkProgressBar: true);

    expect(find.text('Excellent!'), findsOneWidget);
    expect(find.text('You scored 10 out of 10'), findsOneWidget);
    expect(AppState.currentUser!.completedSurLessons, contains(sur1.id));
    expect(AppState.currentUser!.streakDays, 1);
    expect(AppState.currentUser!.totalXp, 100);

    await _tap(tester, find.text('Back to Lessons'));

    // ---- Raag lesson 1 (introduction): fail, retry, pass -------------------
    await tester.tap(_inBottomBar('Raag'));
    await tester.pumpAndSettle();
    final raag1 = raagLessons[0];
    await _tap(tester, find.text(raag1.title));
    expect(tester.takeException(), isNull);
    expect(find.text('Lesson'), findsOneWidget); // renamed from "The story"
    expect(find.text('Start Quiz'), findsOneWidget);

    await _tap(tester, find.text('Start Quiz'));
    await _takeQuiz(tester, raag1.id, correct: false);
    expect(find.text('Keep Practicing!'), findsOneWidget);
    expect(find.text('You scored 0 out of 10'), findsOneWidget);
    expect(AppState.currentUser!.completedRaagLessons, isNot(contains(raag1.id)));
    expect(AppState.currentUser!.streakDays, 1); // still one day, not two

    await _tap(tester, find.text('Retry Quiz'));
    await _takeQuiz(tester, raag1.id, correct: true);
    expect(find.text('Excellent!'), findsOneWidget);
    expect(AppState.currentUser!.completedRaagLessons, contains(raag1.id));
    expect(AppState.currentUser!.streakDays, 1);

    await _tap(tester, find.text('Back to Lessons'));

    // ---- Raag lesson 2 is now unlocked: facts and audio buttons ------------
    final raag2 = raagLessons[1];
    await _tap(tester, find.text(raag2.title));
    expect(tester.takeException(), isNull);
    await tester.scrollUntilVisible(find.text('At a glance'), 300);
    expect(find.text('At a glance'), findsOneWidget);
    expect(find.byType(AudioPlayButton), findsWidgets);
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // ---- Home reflects the progress and the saved data ----------------------
    await tester.tap(_inBottomBar('Home'));
    await tester.pumpAndSettle();
    expect(find.text('1/12'), findsOneWidget);
    expect(find.text('1/11'), findsOneWidget);

    final after = await LocalStorageService.getUserProgress('learner@example.com');
    expect(after!['streakDays'], 1);
    expect(after['totalXp'], 200);
    expect(after['preferredScale'], 'G#');
    expect(after['completedSurLessons'], [sur1.id]);
    expect(after['completedRaagLessons'], [raag1.id]);

    expect(tester.takeException(), isNull);
  });
}
