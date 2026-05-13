class UserProgress {
  String username;
  String email; // Added this
  int surLevel;
  int raagLevel;
  int totalXp;
  int streakDays;
  List<String> completedSurLessons;
  List<String> completedRaagLessons;

  UserProgress({
    required this.username,
    this.email = '',
    this.surLevel = 1,
    this.raagLevel = 1,
    this.totalXp = 0,
    this.streakDays = 0,
    this.completedSurLessons = const [],
    this.completedRaagLessons = const [],
  });

  factory UserProgress.empty(String username) {
    return UserProgress(username: username);
  }
}