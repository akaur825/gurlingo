// lib/models/user_progress.dart

/// Turns a date into a plain "yyyy-MM-dd" string (the phone's local calendar day).
/// Storing the day as text (not a timestamp) avoids time-zone and daylight-saving bugs.
String dateKey(DateTime d) {
  final y = d.year.toString().padLeft(4, '0');
  final m = d.month.toString().padLeft(2, '0');
  final day = d.day.toString().padLeft(2, '0');
  return '$y-$m-$day';
}

class UserProgress {
  String username;
  String email;
  int totalXp;
  int streakDays;
  String? lastActiveDate; // "yyyy-MM-dd" of the last day a quiz was finished
  List<String> completedSurLessons;
  List<String> completedRaagLessons;
  String preferredScale;

  UserProgress({
    required this.username,
    this.email = "",
    this.totalXp = 0,
    this.streakDays = 0,
    this.lastActiveDate,
    List<String>? completedSurLessons,
    List<String>? completedRaagLessons,
    this.preferredScale = 'C#',
  })  : completedSurLessons = completedSurLessons ?? [],
        completedRaagLessons = completedRaagLessons ?? [];

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    // Older saves stored a full timestamp; keep only the "yyyy-MM-dd" part.
    String? last = json['lastActiveDate']?.toString();
    if (last != null && last.length > 10) {
      last = last.substring(0, 10);
    }

    return UserProgress(
      username: json['username'] ?? 'Guest',
      email: json['email'] ?? '',
      totalXp: json['totalXp'] ?? 0,
      streakDays: json['streakDays'] ?? 0,
      lastActiveDate: last,
      completedSurLessons: List<String>.from(json['completedSurLessons'] ?? []),
      completedRaagLessons: List<String>.from(json['completedRaagLessons'] ?? []),
      preferredScale: json['preferredScale'] ?? 'C#',
    );
  }

  /// Note: passwords are NOT part of this object on purpose.
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'totalXp': totalXp,
      'streakDays': streakDays,
      if (lastActiveDate != null) 'lastActiveDate': lastActiveDate,
      'completedSurLessons': completedSurLessons,
      'completedRaagLessons': completedRaagLessons,
      'preferredScale': preferredScale,
    };
  }
}
