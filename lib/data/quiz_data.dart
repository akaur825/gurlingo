import '../models/question.dart';

class QuizData {
  static List<Question> getQuestions(String type, int level) {
    if (type == "Raag") {
      switch (level) {
        case 1: return _getRaagLevel1();
        case 2: return _getRaagLevel2();
        case 3: return _getRaagLevel3();
        default: return [];
      }
    }
    return [];
  }

  static List<Question> _getRaagLevel1() {
    return [
      Question(
        prompt: "What is the definition of Raag?", // Changed from questionText
        options: [ // Changed from answers
          "A set of notes ascending and descending a scale that provoke a specific emotion.",
          "A style of Indian Classical music performed at festivals.",
          "A sequence of notes used in Kirtan without any structure.",
          "A Tanti Saaj used in Kirtan to evoke certain emotions."
        ],
        answer: 0, // Changed from correctAnswerIndex
      ),
    ];
  }

  static List<Question> _getRaagLevel2() {
    return [
      Question(
        prompt: "Which audio is in Raag Bilaval?",
        options: ["Audio 1", "Audio 2", "Audio 3", "Audio 4"],
        answer: 2,
        type: "audio", // Added this to match your model
        audioPath: "audio/Bilaval.mp3", // Model uses audioPath, not answerAudioPaths
      ),
    ];
  }

  static List<Question> _getRaagLevel3() {
    return [
      Question(
        prompt: "Placeholder: What is the Avroh of Raag Gond?",
        options: ["Option 1", "Option 2", "Option 3", "Option 4"],
        answer: 1,
      ),
    ];
  }
}