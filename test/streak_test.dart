import 'package:flutter_test/flutter_test.dart';
import 'package:gurlingo/services/app_state.dart';
import 'package:gurlingo/services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await LocalStorageService.saveUser('Test', 'test@example.com', 'secret123');
    final profile = await LocalStorageService.getUserProgress('test@example.com');
    AppState.login(profile!);
  });

  test('a new account starts at 0 with no completion date', () {
    expect(AppState.currentUser!.streakDays, 0);
    expect(AppState.currentUser!.lastActiveDate, isNull);
  });

  test('first quiz starts the streak at 1 and saves today', () async {
    await AppState.finishQuiz(now: DateTime(2026, 11, 14, 9));
    expect(AppState.currentUser!.streakDays, 1);
    expect(AppState.currentUser!.lastActiveDate, '2026-11-14');

    final saved = await LocalStorageService.getUserProgress('test@example.com');
    expect(saved!['streakDays'], 1);
    expect(saved['lastActiveDate'], '2026-11-14');
  });

  test('a second quiz on the same day does not add to the streak', () async {
    await AppState.finishQuiz(now: DateTime(2026, 11, 14, 9));
    await AppState.finishQuiz(now: DateTime(2026, 11, 14, 22));
    expect(AppState.currentUser!.streakDays, 1);
  });

  test('a quiz on the next day adds 1, even across midnight', () async {
    await AppState.finishQuiz(now: DateTime(2026, 11, 14, 23, 59));
    await AppState.finishQuiz(now: DateTime(2026, 11, 15, 0, 1));
    expect(AppState.currentUser!.streakDays, 2);
    await AppState.finishQuiz(now: DateTime(2026, 11, 16, 12));
    expect(AppState.currentUser!.streakDays, 3);
  });

  test('missing a day resets the streak to 1', () async {
    await AppState.finishQuiz(now: DateTime(2026, 11, 14, 9));
    await AppState.finishQuiz(now: DateTime(2026, 11, 15, 9));
    await AppState.finishQuiz(now: DateTime(2026, 11, 18, 9));
    expect(AppState.currentUser!.streakDays, 1);
    expect(AppState.currentUser!.lastActiveDate, '2026-11-18');
  });

  test('a failed quiz still counts (no XP, streak still moves)', () async {
    await AppState.finishQuiz(xpGained: 0, now: DateTime(2026, 11, 14, 9));
    expect(AppState.currentUser!.streakDays, 1);
    expect(AppState.currentUser!.totalXp, 0);
  });
}
