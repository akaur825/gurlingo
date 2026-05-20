class UserProgress {
  String username;
  String email;
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
    List<String>? completedSurLessons,
    List<String>? completedRaagLessons,
  })  : completedSurLessons = completedSurLessons ?? [],
        completedRaagLessons = completedRaagLessons ?? [];

  // Factory initializer for fresh account profiles
  factory UserProgress.empty(String username, String email) {
    return UserProgress(username: username, email: email);
  }

  // 1. FROM JSON: Converts database map objects into this runtime object
  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      username: json['name'] ?? json['username'] ?? 'User',
      email: json['email'] ?? '',
      surLevel: json['surLevel'] ?? 1,
      raagLevel: json['raagLevel'] ?? 1,
      totalXp: json['totalXp'] ?? 0,
      streakDays: json['streakDays'] ?? 0,
      completedSurLessons: List<String>.from(json['completedSurLessons'] ?? []),
      completedRaagLessons: List<String>.from(json['completedRaagLessons'] ?? []),
    );
  }

  // 2. TO JSON: Packages the current runtime progress values into an exportable map
  Map<String, dynamic> toJson() {
    return {
      'name': username,
      'email': email,
      'surLevel': surLevel,
      'raagLevel': raagLevel,
      'totalXp': totalXp,
      'streakDays': streakDays,
      'completedSurLessons': completedSurLessons,
      'completedRaagLessons': completedRaagLessons,
    };
  }
}