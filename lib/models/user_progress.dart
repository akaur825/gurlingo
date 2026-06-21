// Inside lib/models/user_progress.dart

class UserProgress {
  String username;
  String email;
  int totalXp;
  int streakDays;
  List<String> completedSurLessons;
  List<String> completedRaagLessons;
  String preferredScale; // 👈 Add this field

  UserProgress({
    required this.username,
    this.email = "",
    this.totalXp = 0,
    this.streakDays = 0,
    List<String>? completedSurLessons,
    List<String>? completedRaagLessons,
    this.preferredScale = 'C#', // 👈 Default value
  })  : this.completedSurLessons = completedSurLessons ?? [],
        this.completedRaagLessons = completedRaagLessons ?? [];

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      username: json['username'] ?? 'Guest',
      email: json['email'] ?? '',
      totalXp: json['totalXp'] ?? 0,
      streakDays: json['streakDays'] ?? 0,
      completedSurLessons: List<String>.from(json['completedSurLessons'] ?? []),
      completedRaagLessons: List<String>.from(json['completedRaagLessons'] ?? []),
      preferredScale: json['preferredScale'] ?? 'C#', // 👈 Handle from json
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'totalXp': totalXp,
      'streakDays': streakDays,
      'completedSurLessons': completedSurLessons,
      'completedRaagLessons': completedRaagLessons,
      'preferredScale': preferredScale, // 👈 Handle to json
    };
  }
}