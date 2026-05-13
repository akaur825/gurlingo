class Question {
  final String prompt;
  final List<String> options;
  final dynamic answer; // int for index, bool for true/false
  final String type;    // "identify", "true-false", "audio"
  final String? audioPath;

  Question({
    required this.prompt,
    required this.options,
    required this.answer,
    this.type = "identify",
    this.audioPath,
  });
}

class Lesson {
  final String id;
  final String title;
  final String description;
  final String videoDescription;
  final List<Question> questions;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    this.videoDescription = '',
    required this.questions,
  });
}