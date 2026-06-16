class Question {
  final String prompt;
  final List<String> options;
  final dynamic answer; // int for index, bool for true/false
  final String type;    // "text", "audio_question", "audio_options"
  final String? audioPath; // Used when the question prompt has audio
  final List<String>? optionAudioPaths; // 👇 Added: Used when answer choices are audio

  Question({
    required this.prompt,
    required this.options,
    required this.answer,
    this.type = "text", // Default to simple text multiple-choice
    this.audioPath,
    this.optionAudioPaths,
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