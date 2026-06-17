import '../models/question.dart';

class QuizData {
  static List<Question> getQuestions(String type, int level) {
    if (type == "Raag") {
      switch (level) {
        case 1: return _getRaagLevel1();
        case 2: return _getRaagLevel2();
        case 3: return _getRaagLevel3();
        case 4: return _getRaagLevel4();
        case 5: return _getRaagLevel5();
        case 6: return _getRaagLevel6();
        case 7: return _getRaagLevel7();
        case 8: return _getRaagLevel8();
        case 9: return _getRaagLevel9();
        case 10: return _getRaagLevel10();
        case 11: return _getRaagLevel11();
        default: return [];
      }
    }
    if (type == "Sur") {
      switch (level) {
        case 1: return _getSurLevel1();
        case 2: return _getSurLevel2();
        case 3: return _getSurLevel3();
        case 4: return _getSurLevel4();
        case 5: return _getSurLevel5();
        case 6: return _getSurLevel6();
        case 7: return _getSurLevel7();
        default: return [];
      }
    }
    return [];
  }

  // ========== RAAG LEVEL QUESTION BANKS ==========

  static List<Question> _getRaagLevel1() {
    return [
      Question(
        prompt: "What is the definition of Raag?",
        options: [
          "A set of notes ascending and descending a scale that provoke a specific emotion.",
          "A style of Indian Classical music performed at festivals.",
          "A sequence of notes used in Kirtan without any structure.",
          "A Tanti Saaj used in Kirtan to evoke certain emotions."
        ],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "How many Shudh Raags are there in Sri Guru Granth Sahib Ji?",
        options: ["68", "31", "25", "40"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "What is the term for the ascending scale of a Raag?",
        options: ["Avroh", "Raag", "Aroh", "Sur"],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "What is the second most used Sur in a Raag",
        options: ["Vadi", "Anuvadi", "Vakrit Sur", "Samvadi"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What is the term for notes that are forbidden in a Raag?",
        options: ["Varjit Surs", "Vakrit Surs", "Vadi", "Samvadi"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What is the term for the characteristic phrases of a Raag?",
        options: ["Thaat", "Jaati", "Mukh Ang", "Aroh"],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "What is the correct order of the first five raags?",
        options: [
          "Shree, Maajh, Gauri, Asa, Gujri",
          "Asa, Nat Narayan, Todi, Malhaar, Basant",
          "Asa, Basant, Bhairav, Bilawal, Devgandhari",
          "Basant, Asa, Sarang, Bilwal, Malhaar"
        ],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What is the term for the descending scale of a Raag?",
        options: ["Aroh", "Vadi", "Thaat", "Avroh"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What is the term for the most used note of a Raag?",
        options: ["Samvadi", "Vadi", "Thaat", "Jaati"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "What is the definition of a Thaat",
        options: [
          "A parent scale or framework of notes used to classify Raags",
          "A specific Raag performed at a particular time of day",
          "A rhythmic cycle used to accompany vocal and instrumental music",
          "A type of musical instrument used in Gurmat Sangeet"
        ],
        answer: 0,
        type: "text",
      ),
    ];
  }

  static List<Question> _getRaagLevel2() {
    return [
      Question(
        prompt: "What is the Aroh of Raag Bilaval",
        options: [
          "Sa Re Ga Ma Pa Dha Ni Sa'",
          "Sa Ga Ma Pa Ni Sa'",
          "Sa re ga ma dha ni Sa'",
          "Sa Re Ma Ga Pa Sa'"
        ],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What kind of Surs are used in Raag Bilval?",
        options: ["All Teevar", "All Komal", "All Shudh", "Komal and Teevar"],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "What is the mood of Raag Bilaval?",
        options: ["Sad", "Mysterious", "Devotional", "Joyful and Happy"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What is the Avroh of Raag Bilaval?",
        options: [
          "Sa' Ni Dha Pa Ma Ga Re Sa",
          "Sa' Dha Ma Pa Ga Re Sa",
          "Sa' Ni Dha Pa Ga Re Sa",
          "Sa Re Ga Pa Dha Sa'"
        ],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What is the Vadi of Raag Bilaval?",
        options: ["Ga", "Pa", "Ni", "Ma"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "What is the Samvadi of Raag Bilaval?",
        options: ["Sa", "Dha", "Ni", "Pa"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What time is Raag Bilaval sung",
        options: ["3pm-6pm", "1pm-4pm", "6pm-9pm", "9am-12pm"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "Which audio is in Raag Bilaval?",
        options: ["Audio 1", "Audio 2", "Audio 3", "Audio 4"],
        answer: 2,
        type: "audio_options",
        optionAudioPaths: [
          "assets/audio/Basant.mp3",
          "assets/audio/Gond.mp3",
          "assets/audio/Bilaval.mp3",
          "assets/audio/Maaroo.mp3"
        ],
      ),
    ];
  }

  static List<Question> _getRaagLevel3() {
    return [
      Question(
        prompt: "What is the Avroh of Raag Gond?",
        options: [
          "Sa' ni Dha Pa ma ga Re sa",
          "Sa' Ni Dha Ni Pa Ma Ga Re Sa",
          "Sa' Dha Pa Ga Sa",
          "ni dha Pa ma Ga Re Sa"
        ],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "What kind of notes are used in Raag Gond?",
        options: ["All Shudh", "All Komal", "All Teevar", "Komal and Teevar"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What is the Jaati of Raag Gond?",
        options: ["Audav-Shaudav", "Audav", "Shaudav-Sampooran", "Sampooran Jaati"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What is the Vadi of Raag Gond?",
        options: ["Ga", "Ni", "Ma", "Pa"],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "What is the Samvadi of Raag Gond?",
        options: ["Sa", "Dha", "Ni", "Pa"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What is the Aroh of Raag Gond?",
        options: [
          "Sa Ma Dha Ni",
          "Sa Re Ga Ma Pa Dha Ni Sa'",
          "Sa Re Ga Ma Pa Dha Ni Dha Ni Sa'",
          "Sa re Ga ma Pa dha Ni Sa'"
        ],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What time is Raag Gond sung?",
        options: ["3pm-6pm", "9am-12pm", "1pm-4pm", "6pm-9pm"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "Which audio is in Raag Gond?",
        options: ["Audio 1", "Audio 2", "Audio 3", "Audio 4"],
        answer: 2,
        type: "audio_options",
        optionAudioPaths: [
          "assets/audio/Basant.mp3",
          "assets/audio/Bilaval.mp3",
          "assets/audio/Gond.mp3",
          "assets/audio/Malhaar.mp3"
        ],
      ),
    ];
  }

  static List<Question> _getRaagLevel4() {
    return [
      Question(
        prompt: "What is the Aroh of Raag Basant?",
        options: [
          "Sa Ga Ma Dha Ni Sa'",
          "Sa Re Ga Ma Pa Dha Ni Sa'",
          "Sa Re Ma Pa Dha Sa'",
          "Sa re ga Ma Pa dha Ni Sa'"
        ],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What time is Raag Basant sung?",
        options: ["Fall", "12pm-3pm", "Spring", "6pm-9pm"],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "What is the Jaati of Raag Basant?",
        options: ["Audav-Shaudav", "Audav-Sampooran", "Shaudav-Sampooran", "Audav Jaati"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "What is the Vadi of Raag Basant?",
        options: ["Sa", "Ga", "Ni", "Pa"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What commonly heard Baani is under Raag Basant?",
        options: ["Ardaas", "Basant Mehla Pehla", "Anand Sahib", "Basant Ki Vaar"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What is the Avroh of Raag Basant?",
        options: [
          "Sa' Ni Dha Pa Ma Ga Re Sa",
          "Sa' Dha Ma Ga Re Sa",
          "Sa' Ni Dha Pa ma ga re Sa",
          "Sa' ni dha ma ga re Sa"
        ],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What number Raag is Raag Basant?",
        options: ["1st", "25th", "31st", "27th"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "Which audio is in Raag Basant?",
        options: ["Audio 1", "Audio 2", "Audio 3", "Audio 4"],
        answer: 2,
        type: "audio_options",
        optionAudioPaths: [
          "assets/audio/Bhairo.mp3",
          "assets/audio/Todi.mp3",
          "assets/audio/Basant.mp3",
          "assets/audio/Sarang.mp3"
        ],
      ),
    ];
  }

  static List<Question> _getRaagLevel5() {
    return [
      Question(
        prompt: "What is the Samvadi of Raag Kalyan?",
        options: ["Sa", "Re", "Ni", "Ma"],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "What time is Raag Kalyan sung?",
        options: ["Summer", "Early Morning", "12pm-3pm", "6pm-9pm"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What is the Mishrat form of Raag Kalyan?",
        options: ["Kalyam Bhupali", "Kalyan Maajh", "Kalyan Dakhani", "Kalyan Hindol"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What is the Avroh of Raag Kalyan?",
        options: [
          "Sa' Dha Pa Ma Ga Re Sa",
          "Sa' Ni Pa Ga Sa",
          "Sa' Ni Dha Pa ma Ga Re Sa",
          "Sa' Ma Re Ga Sa"
        ],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "What is the Thaat of Raag Kalyan",
        options: ["Asavari", "Kalyan", "Bilaval", "Todi"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "What is the name of the Indian Classical version of Raag Kalyan?",
        options: ["Raag Bmhimpilasi", "Raag Basant", "Raag Yaman", "Raag Khamaj"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What is the Aroh of Raag Kalyan?",
        options: [
          "Sa Re Ga ma Pa Dha Ni Sa'",
          "Sa Ga Ma Pa Dha Ni Sa'",
          "Sa re Ma Pa Ni Dha Sa'",
          "Sa Re Ga Ma Pa Dha Sa'"
        ],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "Which audio is in Raag Kalyan?",
        options: ["Audio 1", "Audio 2", "Audio 3", "Audio 4"],
        answer: 2,
        type: "audio_options",
        optionAudioPaths: [
          "assets/audio/Todi.mp3",
          "assets/audio/Gond.mp3",
          "assets/audio/Kalyan.mp3",
          "assets/audio/Malhaar.mp3"
        ],
      ),
    ];
  }

  static List<Question> _getRaagLevel6() {
    return [
      Question(
        prompt: "What is the Thaat of Raag Maaroo",
        options: ["Bilaval", "Todi", "Bhairvi", "Khamaaj"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "When is Raag Maaroo sung?",
        options: ["In times of War and Death", "During Marriage", "During Battle", "In times of Death"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What is the Vadi of Raag Maaroo?",
        options: ["Sa", "Ga", "Todi", "Pa"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "How many mishrat raags does Raag Maaroo have?",
        options: ["0", "10", "1", "2"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What is the Aroh of Raag Maaroo?",
        options: ["Sa Ga Ma Pa Dha Ni Sa'", "Sa Re Ga Ma Pa Dha Ni Sa'", "Sa Ga Ma Pa Dha Sa'", "Sa ga ma Pa dha Ni Sa'"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What is the Jaati of Raag Maaroo?",
        options: ["Shaudav Jaati", "Sampooran Jaati", "Shaudav-Sampooran", "Audav-Shaudav"],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "What is the Avroh of Raag Maaroo?",
        options: [
          "Sa' ni Dha Pa, ma Pa Dha ni Dha Pa, Ma Ga Re Sa",
          "Sa' ni Dha Pa, ma Pa dha Ni dha Pa, Ma Ga Re Sa",
          "Sa' Dha Pa Ga Re Sa",
          "Sa' Ni Dha Pa Ma Ga Re Sa"
        ],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "Which audio is in Raag Maaroo?",
        options: ["Audio 1", "Audio 2", "Audio 3", "Audio 4"],
        answer: 3,
        type: "audio_options",
        optionAudioPaths: [
          "assets/audio/Shree.mp3",
          "assets/audio/Sarang.mp3",
          "assets/audio/Todi.mp3",
          "assets/audio/Maaroo.mp3"
        ],
      ),
    ];
  }

  static List<Question> _getRaagLevel7() {
    return [
      Question(
        prompt: "What is the Avroh of Shree Raag?",
        options: [
          "Sa' dha Pa ga re sa",
          "Sa' Ni Dha Pa Ma Ga Re Sa",
          "Sa re ma Pa Ni Sa'",
          "Sa' Ni dha pa ma Ga re Sa"
        ],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "When is Shree Raag sung?",
        options: ["10am-1pm", "6pm-9pm", "Morning", "Midnight"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "What is the Samvadi of Shree Raag?",
        options: ["Pa", "Sa", "Ga", "Ma"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "How many Mishrat Raags does Shree Raag have?",
        options: ["11", "2", "0", "1"],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "What is the Thaat of Shree Raag?",
        options: ["Shree", "Bilaval", "Khamaaj", "Poorvi"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What is the emotion of Shree Raag?",
        options: ["Devotion", "Joy", "Sadness", "Anger"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What is the Aroh of Shree Raag",
        options: ["Sa re Ma Pa Ni Sa'", "Sa Re Ga Pa Dha Sa'", "Sa Ma Pa Dha Ni Sa'", "Sa re ma Pa Ni Sa'"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "Which audio is in Shree Raag?",
        options: ["Audio 1", "Audio 2", "Audio 3", "Audio 4"],
        answer: 2,
        type: "audio_options",
        optionAudioPaths: [
          "assets/audio/Malhaar.mp3",
          "assets/audio/Kalyan.mp3",
          "assets/audio/Shree.mp3",
          "assets/audio/Bhairo.mp3"
        ],
      ),
    ];
  }

  static List<Question> _getRaagLevel8() {
    return [
      Question(
        prompt: "What is the Aroh of Raag Todi?",
        options: [
          "Sa re ga ma, Pa, ma dha Ni Sa'",
          "Sa Ga Ma Pa Ni Sa'",
          "Sa ga ma, Pa, ma dha ma Pa Ni Sa'",
          "Sa' Ni dha pa ma Ga re Sa"
        ],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What is the Thaat of Raag Todi?",
        options: ["Marva", "Bhairav", "Bilaval", "Todi"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What is the Vadi of Raag Todi?",
        options: ["ma", "dha", "Ga", "Sa"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "What is the Avroh of Raag Todi?",
        options: [
          "Sa' Ni dha, Pa, ma dha ma ga re Sa",
          "Sa' Dha Ma Re Sa",
          "Sa' Ni Dha Pa Ma Ga Re Sa",
          "Sa' ni dha Pa ma Ga re Sa"
        ],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What is the emotion of Raag Todi?",
        options: ["Calming", "Devotion", "Serious", "Uplifting"],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "What time is Raag Todi Sung??",
        options: ["6pm-9pm", "9am-6pm", "3am-12pm", "Dawn"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What is the Samvadi of Raag Todi?",
        options: ["dha", "ga", "ma", "ni"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "Which audio is in Raag Todi?",
        options: ["Audio 1", "Audio 2", "Audio 3", "Audio 4"],
        answer: 3,
        type: "audio_options",
        optionAudioPaths: [
          "assets/audio/Shree.mp3",
          "assets/audio/Sarang.mp3",
          "assets/audio/Maaroo.mp3",
          "assets/audio/Todi.mp3"
        ],
      ),
    ];
  }

  static List<Question> _getRaagLevel9() {
    return [
      Question(
        prompt: "What is the Avroh of Raag Sarang?",
        options: [
          "Sa' ni Dha Pa Ma Ga Re Sa",
          "Sa Ga Ma Pa Ni Sa'",
          "Sa' ni Pa Ma Re Sa.",
          "Sa' Ni dha pa ma Ga re Sa"
        ],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "What is the Jaati of Raag Sarang?",
        options: ["Shaudav-Sampooran", "Audav-Sampooran", "Sampooran Jaati", "Audav Jaati"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What is the Samvadi of Raag Sarang?",
        options: ["Re", "Pa", "Sa", "Ma"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "What time is Raag Sarang sung?",
        options: ["12pm-3pm", "6am-9am", "10am-11am", "12pm-3am"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What is the Vadi of Raag Sarang?",
        options: ["Ma", "Sa", "Pa", "Re"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What note has both forms used in Raag Sarang?",
        options: ["Sa", "Ni", "Ga", "Ma"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "What is the Aroh of Raag Sarang?",
        options: ["Sa Ga Ma Pa Ni Sa'", "Sa Re Pa Dha Ni Sa'", "Sa Re Ma Pa Ni Sa'", "sa, re ga ma, re pa Ni dha ni sa'"],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "Which audio is in Raag Sarang?",
        options: ["Audio 1", "Audio 2", "Audio 3", "Audio 4"],
        answer: 0,
        type: "audio_options",
        optionAudioPaths: [
          "assets/audio/Sarang.mp3",
          "assets/audio/Shree.mp3",
          "assets/audio/Malhaar.mp3",
          "assets/audio/Basant.mp3"
        ],
      ),
    ];
  }

  static List<Question> _getRaagLevel10() {
    return [
      Question(
        prompt: "What is the Aroh of Raag Malhaar?",
        options: ["Sa Re Ga Ma Pa ni Dha Ni Sa'", "Sa Re Pa Dha Ni Sa'", "Sa, Re Ga Ma, Re Pa ni Dha Ni Sa'", "sa, re ga ma, re pa Ni dha ni sa'"],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "What is the Jaati of Raag Malhaar?",
        options: ["Shaudav-Sampooran", "Audav-Sampooran", "Audav Jaati", "Sampooran Jaati"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What is the Samvadi of Raag Malhaar?",
        options: ["Sa", "Pa", "Ni", "Ma"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What time is Raag Malhaar sung?",
        options: ["Summer", "Rainy Season", "Snowy Season", "6am-9am"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "What is the Vadi of Raag Malhaar?",
        options: ["ni", "Sa", "Ma", "Dha"],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "What note has both forms used in the Avroh of Raag Malhaar?",
        options: ["Ni", "Ni", "Ga", "Ma"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What is the Avroh of Raag Malhaar?",
        options: ["Sa Re Ga Ma Pa ni Dha Ni Sa'", "Sa' Dha Pa Ga Re Sa", "Sa' Ni Dha ni Pa Ma Ga Re Sa", "Sa' Dha ni Pa, Ga Ma Re Sa"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "Which audio is in Raag Malhaar?",
        options: ["Audio 1", "Audio 2", "Audio 3", "Audio 4"],
        answer: 1,
        type: "audio_options",
        optionAudioPaths: [
          "assets/audio/Basant.mp3",
          "assets/audio/Malhaar.mp3",
          "assets/audio/Kalyan.mp3",
          "assets/audio/Maaroo.mp3"
        ],
      ),
    ];
  }

  static List<Question> _getRaagLevel11() {
    return [
      Question(
        prompt: "What is the Aroh of Raag Bhairo?",
        options: [
          "Sa ni Dha Pa Ma Ga Re Sa",
          "Sa Ga Ma Pa Ni Sa'",
          "Sa re Ga Ma Pa dha Ni Sa'",
          "Sa' Ni dha pa ma Ga re Sa"
        ],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "What is the Jaati of Raag Bhairo",
        options: ["Shaudav-Sampooran", "Audav-Sampooran", "Audav Jaati", "Sampooran Jaati"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What is the Thaat of Raag Bhairo?",
        options: ["Bilval", "Bhairv", "Kalyan", "Bhairavi"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "What time is Raag Bhairo sung?",
        options: ["6am-9am", "12am-3pm", "10pm-11am", "12pm-3pm"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "How many Mishrat Raags does Raag Bhairo have?",
        options: ["1", "3", "0", "2"],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "What is the Aroh of Raag Bhairo?",
        options: ["Sa Re Ga ma Pa Dha Ni Sa'", "sa Re Ga Ma pa Dha Ni sa'", "Sa Re Ga Ma Pa Dha Ni Sa'", "Sa re Ga Ma Pa dha Ni Sa'"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What is the Vadi of Raag Bhairo?",
        options: ["re", "dha", "ma", "ga"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "Which audio is in Raag Bhairo?",
        options: ["Audio 1", "Audio 2", "Audio 3", "Audio 4"],
        answer: 0,
        type: "audio_options",
        optionAudioPaths: [
          "assets/audio/Bhairo.mp3",
          "assets/audio/Kalyan.mp3",
          "assets/audio/Sarang.mp3",
          "assets/audio/Todi.mp3"
        ],
      ),
    ];
  }
  // ========== SUR LEVEL QUESTION BANKS ==========

  static List<Question> _getSurLevel1() {
    return [
      Question(
        prompt: "What is a Sur?",
        options: ["A musical note", "A rhythm pattern", "A type of Raag", "A tempo"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "How many Shudh Surs are in an octave?",
        options: ["12", "5", "7", "8"],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "Which of these is NOT a Sur in Gurmat Sangeet?",
        options: ["Sa", "Do", "Ni", "Dha"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "What is a Vakrit Sur?",
        options: [
          "A forbidden note in a Raag",
          "The 20th Raag in Sri Guru Granth Sahib Ji",
          "A type of Shudh Sur",
          "A variation of a Shudh Sur"
        ],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What are the two types of Vakrit Surs?",
        options: ["Teevar and Komal", "Shree and Maajh", "Achala and Jaati", "Taal and Theka"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What are the 4 Komal Surs?",
        options: ["Sa, Ga, Ma, Pa", "Pa, Dha, Ni, Sa", "Re, Ga, Dha, Ni", "Sa, Pa, Dha, Ni"],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "What is the full name of Sa?",
        options: ["Shadaj", "Sa", "Sarang", "Saaj"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What note is this?",
        options: ["Sa", "Pa", "Ma", "Re"],
        answer: 0,
        type: "audio_question",
        audioPath: "assets/audio/questions/Sa.mp3",
      ),
    ];
  }

  static List<Question> _getSurLevel2() {
    return [
      Question(
        prompt: "What is the full name of Re?",
        options: ["Rishad", "Re", "Rishab", "Rela"],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "Which Shudh Sur comes after Sa in the Saptak (scale)?",
        options: ["Ga", "Re", "Ma", "Pa"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "What note is this?",
        options: ["Sa", "Pa", "Ga", "Re"],
        answer: 3,
        type: "audio_question",
        audioPath: "assets/audio/questions/Re.mp3",
      ),
      Question(
        prompt: "What note is this?",
        options: ["re", "Re", "ga", "Ga"],
        answer: 0,
        type: "audio_question",
        audioPath: "assets/audio/questions/re2.mp3",
      ),
      Question(
        prompt: "What do you hear?",
        options: ["Sa Re", "Re Sa", "Sa Sa", "Re Re"],
        answer: 0,
        type: "audio_question",
        audioPath: "assets/audio/questions/Level_1_Sa_Re.mp3",
      ),
      Question(
        prompt: "What do you hear?",
        options: ["Sa Sa Sa Sa", "Re Re Re Re", "Sa Re Sa Re", "Re Sa Re Sa"],
        answer: 2,
        type: "audio_question",
        audioPath: "assets/audio/questions/Level_1_Sa_Re_Sa_Re.mp3",
      ),
    ];
  }

  static List<Question> _getSurLevel3() {
    return [
      Question(
        prompt: "What is the full name of Ga?",
        options: ["Gandhar", "Gujri", "Gandhyam", "Gond"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "Which note comes after Re?",
        options: ["Pa", "Sa", "Ga", "Ma"],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "What note is this?",
        options: ["re", "Ga", "ga", "Ma"],
        answer: 1,
        type: "audio_question",
        audioPath: "assets/audio/questions/Ga2.mp3",
      ),
      Question(
        prompt: "What do you hear?",
        options: ["Sa ga re", "Sa Ga Re", "ga Ga Re", "Ga ga Re"],
        answer: 3,
        type: "audio_question",
        audioPath: "assets/audio/questions/Level_2_Ga_ga_Re.mp3",
      ),
      Question(
        prompt: "What do you hear?",
        options: ["Sa re ga Ga", "Sa Ga Ga Re", "Sa Re Re ga", "Ga Re Sa Sa"],
        answer: 1,
        type: "audio_question",
        audioPath: "assets/audio/questions/Level_2_Sa_Ga_Ga_re.mp3",
      ),
      Question(
        prompt: "What is the order of notes in this audio?",
        options: ["ga Sa Ga re Sa", "Ga Sa Ga re Sa", "Sa Sa Ga re Sa", "Sa Re Ga Ma"],
        answer: 0,
        type: "audio_question",
        audioPath: "assets/audio/questions/Level_2_ga_Sa_Ga_re_Sa.mp3",
      ),
    ];
  }

  static List<Question> _getSurLevel4() {
    return [
      Question(
        prompt: "What is the full name of Ma?",
        options: ["Malhaar", "Madhayam", "Gandhar", "Mandar"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "Which note comes directly before Ma in the scale?",
        options: ["Pa", "Re", "Ga", "Sa"],
        answer: 2,
        type: "text",
      ),
      Question(
        prompt: "What note is this?",
        options: ["ga", "Ma", "Ga", "Ma"],
        answer: 3,
        type: "audio_question",
        audioPath: "assets/audio/questions/Ma2.mp3",
      ),
      Question(
        prompt: "What do you hear?",
        options: ["Sa Re Ga Ma", "Re Ga Ma Pa", "Ma Ga Re Sa", "Sa Ma Re Pa"],
        answer: 0,
        type: "audio_question",
        audioPath: "assets/audio/questions/Level_3_Sa_Re_Ga_Ma.mp3",
      ),
      Question(
        prompt: "What do you hear?",
        options: ["Ga Ma ga ma", "Ma ma ga Ma", "ga Ma Ma ga", "ma ga ga ma"],
        answer: 1,
        type: "audio_question",
        audioPath: "assets/audio/questions/Level_3_Ma_ma_ga_Ma.mp3",
      ),
      Question(
        prompt: "What do you hear?",
        options: ["Sa re ga ma Pa ni", "sa re ma ga ma re", "Sa re Ma ga ma re", "Ma Ga Re Sa Ga Sa"],
        answer: 2,
        type: "audio_question",
        audioPath: "assets/audio/questions/Level_3_Sa_re_Ma_ga_ma_re.mp3",
      ),
    ];
  }

  static List<Question> _getSurLevel5() {
    return [
      Question(
        prompt: "What is the full name of Pa?",
        options: ["Pancham", "Panchat", "Pritham", "Partaal"],
        answer: 0,
        type: "text",
      ),
      Question(
        prompt: "What note is this?",
        options: ["pa", "ma", "Pa", "Sa"],
        answer: 2,
        type: "audio_question",
        audioPath: "assets/audio/questions/Pa.mp3",
      ),
      Question(
        prompt: "What type of Sur is Pa?",
        options: ["Vakrit", "Achala", "Teevar", "Komal"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "What do you hear?",
        options: ["Pa Ma Ga Ga Re", "Pa Ga Re Sa Ga", "Sa Ga Ma Pa Ma", "Pa ma Ga ga Re"],
        answer: 3,
        type: "audio_question",
        audioPath: "assets/audio/questions/Level_4_Pa_ma_Ga_ga_re.mp3",
      ),
      Question(
        prompt: "What is the highest note in this audio?",
        options: ["Pa", "ga", "Sa", "Ni"],
        answer: 0,
        type: "audio_question",
        audioPath: "assets/audio/questions/Level_4_Sa_ga_Pa_ma_Re.mp3",
      ),
      Question(
        prompt: "What note is missing in this sequence?",
        options: ["Ga", "Re", "Ma", "Pa"],
        answer: 2,
        type: "audio_question",
        audioPath: "assets/audio/questions/Level_4_Sa_Re_Ga_Ma_Pa.mp3",
      ),
    ];
  }

  static List<Question> _getSurLevel6() {
    return [
      Question(
        prompt: "What is the full name of Dha?",
        options: ["Dhaivar", "Dhan", "Dhrupad", "Dhaivat"],
        answer: 3,
        type: "text",
      ),
      Question(
        prompt: "What note is this?",
        options: ["Dha", "dha", "ma", "Pa"],
        answer: 1,
        type: "audio_question",
        audioPath: "assets/audio/questions/Dha.mp3",
      ),
      Question(
        prompt: "What notes do you hear?",
        options: ["Dha Dha Pa Ga Ma", "dha dha Pa ga Ma", "Dha Dha Pa ga ma", "Dha dha Pa ga Ma"],
        answer: 3,
        type: "audio_question",
        audioPath: "assets/audio/questions/Level_5_Dha_dha_Pa_ga_Ma.mp3",
      ),
      Question(
        prompt: "How many distinct notes do you hear?",
        options: ["5", "4", "6", "7"],
        answer: 2,
        type: "audio_question",
        audioPath: "assets/audio/questions/Level_5_Sa_Re_Ga_Ma_Pa_Dha.mp3",
      ),
      Question(
        prompt: "What are the two types of Surs that Dha has?",
        options: ["Only Achala", "Shudh and Komal", "Shudh and Teevar", "Achala and Vakrit"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "What do you hear?",
        options: ["dha Pa ga Re Sa re Sa", "Dha Pa Ga Re Sa Re Sa", "dha Pa ga re Sa Sa Sa", "dha Pa ga re Sa Re Sa"],
        answer: 0,
        type: "audio_question",
        audioPath: "assets/audio/questions/Level_5_dha_Pa_ga_Re_Sa_re_Sa.mp3",
      ),
    ];
  }

  static List<Question> _getSurLevel7() {
    return [
      Question(
        prompt: "What is the full name of Ni?",
        options: ["Naam", "Nishad", "Nitnem", "Nidhar"],
        answer: 1,
        type: "text",
      ),
      Question(
        prompt: "What note is this?",
        options: ["Ni", "ni", "Pa", "Ma"],
        answer: 0,
        type: "audio_question",
        audioPath: "assets/audio/questions/Ni.mp3",
      ),
      Question(
        prompt: "Choose the correct order of notes you hear?",
        options: ["Dha Ni Ma Pa", "Dha ni Pa Ma", "Ga Ma Re Sa", "Pa Dha Ni Ma"],
        answer: 1,
        type: "audio_question",
        audioPath: "assets/audio/questions/Level_6_Dha_ni_Pa_Ma.mp3",
      ),
      Question(
        prompt: "How many times do you hear Ni in this sequence?",
        options: ["2", "6", "3", "1"],
        answer: 2,
        type: "audio_question",
        audioPath: "assets/audio/questions/Level_6_Ni_Dha_Ni_Ma_Pa_Ni.mp3",
      ),
      Question(
        prompt: "What notes do you hear?",
        options: ["Ni ni dha Pa Dha ni Ma", "ni ni dha Pa dha ni ma", "ni ni Dha Pa Dha ni Ma", "Sa'ni Pa Ga Ma Ga Sa"],
        answer: 0,
        type: "audio_question",
        audioPath: "assets/audio/questions/Level_6_Ni_ni_dha_Pa_Dha_ni_Ma.mp3",
      ),
      Question(
        prompt: "What is the last Shudh Sur of the Saptak?",
        options: ["Dha", "Sa'", "Ni'", "Ni"],
        answer: 3,
        type: "text",
      ),
    ];
  }
}