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
    if (type == "Sur") {
      switch (level) {
        case 1: return _getSurLevel1();
        // You can add case 2, case 3, etc., as you build them out!
        default: return []; // Fallback so it doesn't crash
      }
    }
    return [];
  }

  static List<Question> _getSurLevel1() {
    return [
      Question(
        prompt: "What is the very first fundamental note (Sharaj) in the scale?",
        options: ["Re", "Sa", "Ga", "Ma"],
        answer: 1, // Sa is index 1
        type: "text",
      ),
    ];
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
        type: "audio_question", // Added this to match your model
        audioPath: "assets/audio/Bilaval.mp3", // Model uses audioPath, not answerAudioPaths
      ),
    ];
  }

  static List<Question> _getRaagLevel3() {
    return [
      Question(
        prompt: "Which audio is the Avroh of Raag Gond?",
        options: ["Clip 1", "Clip 2", "Clip 3", "Clip 4"],
        answer: 1,
        type: "audio_options",
        optionAudioPaths: [
          "assets/audio/gondAvroh.mp3",
          "assets/audio/bilavalAvroh.mp3",
          "assets/audio/asaAvroh.mp3",
          "assets/audio/kalyanAvroh.mp3"
        ]
      ),
    ];
  }
}