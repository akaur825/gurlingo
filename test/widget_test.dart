import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gurlingo/data/lesson_data.dart';
import 'package:gurlingo/data/quiz_data.dart';
import 'package:gurlingo/main.dart';
import 'package:gurlingo/screens/lesson_player_screen.dart';
import 'package:gurlingo/screens/main_screen.dart';
import 'package:gurlingo/services/app_state.dart';
import 'package:gurlingo/theme/app_theme.dart';
import 'package:gurlingo/widgets/quiz_widget.dart';
import 'package:gurlingo/widgets/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Phone, tablet and wide desktop window.
const _sizes = <String, Size>{
  'phone': Size(360, 640),
  'tablet': Size(768, 1024),
  'desktop': Size(1280, 800),
};

Widget _app(Widget home) => MaterialApp(
      theme: AppTheme.light(),
      builder: (context, child) => AppFrame(child: child ?? const SizedBox()),
      home: home,
    );

void _useSize(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTheme.useGoogleFonts = false; // no font downloads in tests
    // audioplayers talks to the platform; answer its calls with nothing.
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    for (final channel in const [
      'xyz.luan/audioplayers',
      'xyz.luan/audioplayers.global',
    ]) {
      messenger.setMockMethodCallHandler(MethodChannel(channel), (_) async => null);
    }
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    AppState.currentUser = null;
  });

  testWidgets('app starts on the welcome screen', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('I Already Have an Account'), findsOneWidget);
  });

  for (final entry in _sizes.entries) {
    group('layout on ${entry.key} (${entry.value.width.toInt()} px)', () {
      testWidgets('welcome screen has no overflow', (tester) async {
        _useSize(tester, entry.value);
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.text('Get Started'), findsOneWidget);
      });

      testWidgets('home screen has no overflow', (tester) async {
        _useSize(tester, entry.value);
        AppState.login({
          'username': 'Test',
          'email': 'test@example.com',
          'totalXp': 120,
          'streakDays': 3,
          'preferredScale': 'C#',
          'completedSurLessons': <String>[],
          'completedRaagLessons': <String>[],
        });
        await tester.pumpWidget(_app(const MainScreen()));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.text('Sur'), findsWidgets);
        expect(find.text('0/12'), findsOneWidget);
        expect(find.text('0/11'), findsOneWidget);
      });

      testWidgets('lesson page and quiz have no overflow', (tester) async {
        _useSize(tester, entry.value);
        AppState.login({
          'username': 'Test',
          'email': 'test@example.com',
          'preferredScale': 'C#',
        });
        await tester.pumpWidget(_app(
          LessonPlayer(lesson: raagLessons[1], lessonType: 'raag'),
        ));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.text('Start Quiz'), findsOneWidget);

        await tester.tap(find.text('Start Quiz'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.text('Check Answer'), findsOneWidget);
      });
    });
  }

  testWidgets('quiz audio buttons toggle play and stop', (tester) async {
    _useSize(tester, _sizes['phone']!);
    // raag-2 has audio_options questions with a play button on every choice.
    final questions = QuizData.getQuiz('raag-2', scale: 'C#');
    final index = questions.indexWhere((q) => q.type == 'audio_options');
    expect(index, isNonNegative);

    await tester.pumpWidget(_app(Scaffold(
      body: QuizWidget(
        questions: [questions[index]],
        onComplete: (_, __) {},
      ),
    )));
    await tester.pump();

    expect(find.byIcon(Icons.play_arrow_rounded), findsNWidgets(4));
    await tester.tap(find.byIcon(Icons.play_arrow_rounded).first);
    await tester.pump();
    expect(find.byIcon(Icons.stop_rounded), findsOneWidget);

    await tester.tap(find.byIcon(Icons.stop_rounded));
    await tester.pump();
    expect(find.byIcon(Icons.stop_rounded), findsNothing);
    expect(find.byIcon(Icons.play_arrow_rounded), findsNWidgets(4));
  });
}
