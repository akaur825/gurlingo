// lib/data/quiz_data.dart
//
// One quiz per lesson, looked up by lesson id (the same ids used in
// lesson_data.dart):
//   raag-1 .. raag-11   (11 Raag quizzes)
//   sur-1 .. sur-7      (7 Shudh Sur quizzes)
//   vakrit-1 .. vakrit-5 (5 Vakrit Sur quizzes)
//
// Question types (see Question / QuizWidget):
//   text           - plain multiple choice
//   audio_question - the prompt has one play button (audioPath)
//   audio_options  - the choices are always "Audio 1".."Audio 4", each with its
//                    own play button (optionAudioPaths)
//
// Sequences use the app notation: S R G M P D N are Shudh, r g d n are Komal,
// m is Teevar, and S' is the high Sa. The audio files do not mark the
// apostrophe; LessonAudioService ignores it.

import '../models/question.dart';
import '../services/app_state.dart';
import '../services/lesson_audio_service.dart';

class QuizData {
  /// The questions for one lesson. Returns an empty list for an unknown id.
  /// [scale] ('C#' or 'G#') defaults to the signed-in user's preferred scale.
  static List<Question> getQuiz(String lessonId, {String? scale}) {
    final s = scale ?? AppState.currentUser?.preferredScale ?? 'C#';
    final builder = _quizzes[lessonId];
    return builder == null ? [] : builder(s);
  }

  static bool hasQuiz(String lessonId) => _quizzes.containsKey(lessonId);

  static final Map<String, List<Question> Function(String)> _quizzes = {
    // Raag, in the same order as raagLessons in lesson_data.dart.
    'raag-1': _raagIntro,
    'raag-2': _bilaval,
    'raag-3': _basant,
    'raag-4': _kalyan,
    'raag-5': _bhairo,
    'raag-6': _todi,
    'raag-7': _sarang,
    'raag-8': _gond,
    'raag-9': _malhar,
    'raag-10': _sri,
    'raag-11': _maru,
    // Shudh Sur
    'sur-1': _sur1,
    'sur-2': _sur2,
    'sur-3': _sur3,
    'sur-4': _sur4,
    'sur-5': _sur5,
    'sur-6': _sur6,
    'sur-7': _sur7,
    // Vakrit Sur
    'vakrit-1': _vakrit1,
    'vakrit-2': _vakrit2,
    'vakrit-3': _vakrit3,
    'vakrit-4': _vakrit4,
    'vakrit-5': _vakrit5,
  };

  // ------------------------------------------------------------------ helpers

  static const List<String> _audioLabels = [
    'Audio 1',
    'Audio 2',
    'Audio 3',
    'Audio 4',
  ];

  /// Plain text question.
  static Question _text(String prompt, List<String> options, int answer) {
    return Question(
      prompt: prompt,
      options: options,
      answer: answer,
      type: 'text',
    );
  }

  /// Prompt with one audio button playing the sargam [sequence].
  static Question _listen(
    String scale,
    String prompt,
    String sequence,
    List<String> options,
    int answer,
  ) {
    return Question(
      prompt: prompt,
      options: options,
      answer: answer,
      type: 'audio_question',
      audioPath: LessonAudioService.sargamAudio(scale, sequence),
    );
  }

  /// Choices are Audio 1..4, each playing one sargam from [sequences].
  static Question _pick(
    String scale,
    String prompt,
    List<String> sequences,
    int answer,
  ) {
    return Question(
      prompt: prompt,
      options: _audioLabels,
      answer: answer,
      type: 'audio_options',
      optionAudioPaths: [
        for (final s in sequences) LessonAudioService.sargamAudio(scale, s),
      ],
    );
  }

  /// Choices are Audio 1..4, each playing a Raag recording such as
  /// 'bilaval aroh' or 'maru avroh'.
  static Question _pickRaag(
    String scale,
    String prompt,
    List<String> recordings,
    int answer,
  ) {
    return Question(
      prompt: prompt,
      options: _audioLabels,
      answer: answer,
      type: 'audio_options',
      optionAudioPaths: [
        for (final r in recordings)
          LessonAudioService.raagAudioByKey(
            scale,
            r.split(' ').first,
            avroh: r.split(' ').last == 'avroh',
          ),
      ],
    );
  }

  // ===================================================================== RAAG

  // Raag Level 1 - Introduction to Raag
  static List<Question> _raagIntro(String scale) => [
        _text("What is a Raag?", [
          "A set of notes ascending and descending a scale that provokes a specific emotion.",
          "A rhythmic pattern used in Kirtan",
          "A type of musical instrument",
          "A collection of Shabads from Sri Guru Granth Sahib Ji",
        ], 0),
        _text("How many Shudh Raags are there in Sri Guru Granth Sahib Ji?",
            ["25", "31", "40", "68"], 1),
        _text("What is the ascending movement of a Raag called?",
            ["Avroh", "Mukh Ang", "Aroh", "Jaati"], 2),
        _text("What is the descending movement of a Raag called?",
            ["Aroh", "Avroh", "Thaat", "Anuvaadee"], 1),
        _text("What is the most prominent note in a Raag called?",
            ["Samvaadee", "Anuvaadee", "Vaadee", "Varjit"], 2),
        _text("What is the second most important note in a Raag called?",
            ["Vaadee", "Samvaadee", "Anuvaadee", "Varjit"], 1),
        _text("What does Varjit mean?",
            ["Prominent", "Pure", "Forbidden or omitted", "Ascending"], 2),
        _text("What does Jaati describe?", [
          "The emotion of a Raag",
          "The number of notes used in the Aroh and Avroh",
          "The time a Raag is sung",
          "The most important note of a Raag",
        ], 1),
        _text("What is Mukh Ang?", [
          "The parent scale of a Raag",
          "The emotion created by a Raag",
          "The characteristic or identifying phrases of a Raag",
          "The number of notes in a Raag",
        ], 2),
        _text("What is Thaat?", [
          "The parent scale of a Raag",
          "The time a Raag is sung",
          "The emotion of a Raag",
          "A rhythmic pattern used in kirtan",
        ], 0),
      ];

  // Raag Level 2 - Bilaval
  static List<Question> _bilaval(String scale) => [
        _text("What is the mood associated with Raag Bilaval?", [
          "Seriousness and contemplation",
          "Joy and contentment",
          "Intense strength",
          "Longing and separation",
        ], 1),
        _text("Which Thaat does Raag Bilaval belong to?",
            ["Khamaj", "Kalyan", "Bilaval", "Todi"], 2),
        _text("What is the Jaati of Raag Bilaval?", [
          "Audav-Sampooran",
          "Shadav-Sampooran",
          "Sampooran-Sampooran",
          "Audav-Audav",
        ], 2),
        _text("What is the Aroh of Raag Bilaval?",
            ["SRGMPDNS'", "SGMPDNS'", "SRGMPNS'", "SRMGPDS'"], 0),
        _text("What is the Avroh of Raag Bilaval?",
            ["S'NDPMGRS", "S'DPMGRS", "S'NPMGRS", "S'NDGRS"], 0),
        _text("What is the Vaadee of Raag Bilaval?", ["G", "D", "N", "M"], 1),
        _text("What is the Samvaadee of Raag Bilaval?", ["S", "G", "N", "P"], 1),
        _text("When is Raag Bilaval traditionally sung?",
            ["6 AM–9 AM", "9 AM–12 PM", "12 PM–3 PM", "6 PM–9 PM"], 1),
        _text("Which of the following is the Mukh Ang of Bilaval?", [
          "GR, GPDP, MG, MRS",
          "RGM, PM, MPNDNP",
          "GMDNS, SNDPMGRS",
          "NRG, RGMPR, NRS",
        ], 0),
        _pickRaag(scale, "Which audio example is Raag Bilaval?",
            ['bilaval aroh', 'gond aroh', 'maru aroh', 'sarang aroh'], 0),
      ];

  // Raag Level 4 - Basant
  static List<Question> _basant(String scale) => [
        _text("What does “Basant” refer to?",
            ["Rain", "Spring", "Winter", "Sunset"], 1),
        _text("What is the Jaati of Raag Basant?", [
          "Audav-Sampooran",
          "Audav-Audav",
          "Shadav-Sampooran",
          "Sampooran-Sampooran",
        ], 0),
        _text("What is the Aroh of Raag Basant?",
            ["SGMDNS'", "SRGMPDNS'", "SRMPDNS'", "SGMPDS'"], 0),
        _text("Which notes are Varjit in the Aroh of Basant?",
            ["G and D", "R and P", "S and M", "D and N"], 1),
        _text("What is the Vaadee of Raag Basant?", ["S", "M", "G", "N"], 0),
        _text("What is the Samvaadee of Raag Basant?", ["S", "P", "M", "N"], 2),
        _text("When is Raag Basant traditionally associated with being sung?",
            [
              "During spring",
              "During winter",
              "Around sunset",
              "During the late morning",
            ], 0),
        _text("What idea can Basant symbolize in Gurmat Sangeet?", [
          "Inner rejuvenation and a fresh start",
          "Anger and strength",
          "Separation and longing",
          "Fear and seriousness",
        ], 0),
        _text("What is one mixed form (mishrat) of Basant mentioned in the lesson?",
            [
              "Basant Bhupali",
              "Basant Hindol",
              "Basant Kalyan",
              "Basant Maajh",
            ], 1),
        _pickRaag(scale, "Which audio example is Raag Basant?",
            ['maru aroh', 'todi aroh', 'basant aroh', 'bhairo aroh'], 2),
      ];

  // Raag Level 5 - Kalyan
  static List<Question> _kalyan(String scale) => [
        _text("Raag Kalyan is closely connected to which well-known Hindustani Raag?",
            ["Bhairav", "Yaman", "Todi", "Malhar"], 1),
        _text("Which Thaat does Raag Kalyan belong to?",
            ["Bilaval", "Khamaj", "Kalyan", "Todi"], 2),
        _text("What is the Jaati of Raag Kalyan?", [
          "Audav-Sampooran",
          "Shadav-Sampooran",
          "Sampooran-Sampooran",
          "Audav-Audav",
        ], 2),
        _text("Which of the following is the Mukh Ang of Kalyan?", [
          "SRGM,MGP,NS",
          "N.Rg, PMG, DNDNS'",
          "N.RG, GRGmPR, N.RS",
          "SMGP, nP, NR'S'",
        ], 2),
        _text("What is the Vaadee of Raag Kalyan?", ["G", "M", "N", "S"], 0),
        _text("What is the Samvaadee of Raag Kalyan?", ["S", "R", "N", "P"], 2),
        _text("What is the Aroh of Raag Kalyan?", [
          "N.RG, mP, mD, NS'",
          "SRGMPDNS'",
          "SGMPDNS'",
          "SRMPNS'",
        ], 0),
        _text("What is the Avroh of Raag Kalyan?", [
          "S'NDPmGRNRS",
          "S'DPMGRS",
          "S'NPGRS",
          "S'NDPMRS",
        ], 0),
        _text("What feeling is associated with Raag Kalyan?", [
          "Peace, serenity, and inner balance",
          "Anger and intensity",
          "Sadness and despair",
          "Enthusiasm and longing",
        ], 0),
        _pickRaag(scale, "Which audio example is Raag Kalyan?",
            ['kalyan avroh', 'bilaval avroh', 'sri avroh', 'todi avroh'], 0),
      ];

  // Raag Level 11 - Bhairo
  static List<Question> _bhairo(String scale) => [
        _text("What is the Mukh Ang of Bhairo?", [
          "SrGM, PdNS'",
          "GMddP, GMrrS",
          "nDNS, DnP, MR, S",
          "PMGRS, N.Sr, GMG",
        ], 1),
        _text("Which Thaat does Raag Bhairo belong to?",
            ["Kalyan", "Bilaval", "Bhairav", "Khamaj"], 2),
        _text("What is the Jaati of Raag Bhairo?", [
          "Audav-Sampooran",
          "Shadav-Sampooran",
          "Audav-Audav",
          "Sampooran-Sampooran",
        ], 3),
        _text("Which two Surs are Komal in Bhairo?",
            ["r and d", "g and n", "r and g", "d and n"], 0),
        _text("What is the Aroh of Raag Bhairo?",
            ["SrGMPDNS'", "SrGMPdNS'", "SGMPdNS'", "SRGMPdNS'"], 1),
        _text("What is the Vaadee of Raag Bhairo?", ["R", "G", "D", "M"], 2),
        _text("What is the Samvaadee of Raag Bhairo?", ["S", "R", "G", "P"], 1),
        _text("When is Raag Bhairo traditionally sung?",
            ["Dawn", "Afternoon", "Spring", "Rainy Season"], 0),
        _text("What helps give Bhairo its serious character beyond simply its Aroh and Avroh?",
            [
              "The treatment and ornamentation of its notes",
              "Its use of only five notes",
              "Its lack of Komal notes",
              "Its association with spring",
            ], 0),
        _pickRaag(scale, "Which audio example is Raag Bhairo?",
            ['sri aroh', 'todi aroh', 'basant aroh', 'bhairo avroh'], 3),
      ];

  // Raag Level 8 - Todi
  static List<Question> _todi(String scale) => [
        _text("Which Thaat does Raag Todi belong to?",
            ["Todi", "Kalyan", "Bhairav", "Bilaval"], 0),
        _text("Which Surs are Komal in Todi?", [
          "r, g, and d",
          "g, m, and n",
          "r, m, and d",
          "d, p, and n",
        ], 0),
        _text("Which Sur is Teevra in Todi?", ["r", "g", "m", "n"], 2),
        _text("What is the Jaati of Raag Todi?", [
          "Audav-Sampooran",
          "Shadav-Sampooran",
          "Sampooran-Sampooran",
          "Audav-Audav",
        ], 2),
        _text("What is the Vaadee of Raag Todi?", ["G", "D", "M", "S"], 1),
        _text("What is the Samvaadee of Raag Todi?", ["G", "N", "M", "R"], 0),
        _text("What is the general character of Todi?", [
          "Introspective and reflective",
          "Joyful and playful",
          "Energetic and celebratory",
          "Strong and aggressive",
        ], 0),
        _text("What number raag is Raag Todi?", ["12", "21", "4", "14"], 0),
        _text("Which of the following is the Mukh Ang of Todi?", [
          "SN.D., PMG, rS",
          "d.N.S, rg, mgrg, rS",
          "DNS, GRPM, mgrS",
          "SR, gr, m, Pdn, Sr'",
        ], 1),
        _pickRaag(scale, "Which audio example is Raag Todi?",
            ['todi avroh', 'sarang avroh', 'basant avroh', 'malhar avroh'], 0),
      ];

  // Raag Level 9 - Sarang
  static List<Question> _sarang(String scale) => [
        _text("What is the Jaati of Raag Sarang?", [
          "Audav-Audav",
          "Audav-Sampooran",
          "Shadav-Sampooran",
          "Sampooran-Sampooran",
        ], 0),
        _text("Which two notes are Varjit in Sarang?",
            ["R and M", "G and D", "D and N", "G and P"], 1),
        _text("What is the Aroh of Raag Sarang?",
            ["SRMPNS'", "SRGMPDNS'", "SGMPNS'", "SRMPDNS'"], 0),
        _text("What is the Avroh of Raag Sarang?",
            ["S'nPMRS", "S'NDPMGRS", "S'DPMRS", "S'NPGRS"], 0),
        _text("Which note has both forms used in Raag Sarang?",
            ["G", "M", "N", "D"], 2),
        _text("What is the Vaadee of Raag Sarang?", ["R", "P", "S", "M"], 0),
        _text("What is the Samvaadee of Raag Sarang?", ["R", "P", "N", "S"], 1),
        _text("Which Thaat does Raag Sarang belong to?",
            ["Purvi", "Kafi", "Bilaval", "Khamaj"], 1),
        _text("What is the Mukh Ang of Raag Sarang?", [
          "SRG, RGP, GPDn, S'",
          "N.SR, MR, PMR, N.S",
          "NDnP, MPNS', PDMG",
          "nSr, gr, mPd, nS'",
        ], 1),
        _pickRaag(scale, "Which audio example is Raag Sarang?",
            ['todi avroh', 'malhar avroh', 'sarang avroh', 'maru avroh'], 2),
      ];

  // Raag Level 3 - Gond
  static List<Question> _gond(String scale) => [
        _text("Which Thaat does Raag Gond belong to?",
            ["Khamaj", "Bilaval", "Todi", "Kalyan"], 1),
        _text("What is the Jaati of Raag Gond?", [
          "Audav-Audav",
          "Shadav-Sampooran",
          "Sampooran-Sampooran",
          "Audav-Sampooran",
        ], 2),
        _text("What is the Aroh of Raag Gond?",
            ["SRGMPDNS'", "SRGMPDNDNS'", "SGMPDNS'", "SRGMPNS'"], 1),
        _text("What is the Avroh of Raag Gond?",
            ["S'NDNPMGRS", "S'NDPMGRS", "S'DNPMGRS", "S'NPMGRS"], 0),
        _text("What is the Vaadee of Raag Gond?", ["G", "M", "P", "N"], 1),
        _text("What is the Samvaadee of Raag Gond?", ["S", "R", "P", "N"], 0),
        _text("What characteristic movement helps distinguish Gond from Bilaval?",
            ["GRG", "DNDN", "MGRS", "SRGM"], 1),
        _text("What feeling is associated with Raag Gond?",
            ["Longing", "Peace", "Joy", "Seriousness"], 0),
        _text("What is the Mukh Ang of Raag Gond?", [
          "GR, GPDP, MG, MRS",
          "RGM, PM, MPNDNP, DMGM",
          "GMDNS, SNDPMGRS",
          "NRG, RGMPR, NRS",
        ], 1),
        _pickRaag(scale, "Which audio example is Raag Gond?",
            ['bilaval aroh', 'sri aroh', 'malhar aroh', 'gond aroh'], 3),
      ];

  // Raag Level 10 - Malhar
  static List<Question> _malhar(String scale) => [
        _text("What is Raag Malhar traditionally associated with?",
            ["Winter", "The rainy season", "Spring", "Sunset"], 1),
        _text("Which Thaat does Raag Malhar belong to?",
            ["Kalyan", "Bilaval", "Khamaj", "Todi"], 2),
        _text("What is the Jaati of Raag Malhar?", [
          "Audav-Sampooran",
          "Shadav-Sampooran",
          "Audav-Audav",
          "Sampooran-Sampooran",
        ], 3),
        _text("Which note has both forms used in Raag Malhar?",
            ["G", "N", "D", "M"], 1),
        _text("What is the Vaadee of Raag Malhar?", ["S", "P", "M", "N"], 2),
        _text("What is the Samvaadee of Raag Malhar?", ["S", "P", "N", "M"], 0),
        _text("Which movement is characteristic of Malhar?",
            ["MRP", "GRG", "SND", "RGMP"], 0),
        _text("What is the Aroh of Raag Malhaar?", [
          "S, RGM, MRP, nDNS'",
          "S, MGR, PRM, NdnS'",
          "S', DnPM, GMRS",
          "S', PMDn, gmrS",
        ], 0),
        _text("What is the Avroh of Raag Malhar?", [
          "S'NDPMGRS",
          "S', DnPM, GMRS",
          "S, RGM, MRP, nDNS'",
          "SMGP, MP, NDS'",
        ], 1),
        _pickRaag(scale, "Which audio example is Raag Malhar?",
            ['kalyan aroh', 'malhar aroh', 'basant aroh', 'sri aroh'], 1),
      ];

  // Raag Level 7 - Sri Raag
  static List<Question> _sri(String scale) => [
        _text("What number raag is Sri Raag?", ["7", "1", "15", "31"], 1),
        _text("Which Thaat does Sri Raag belong to?",
            ["Bilaval", "Khamaj", "Purvi", "Todi"], 2),
        _text("What is the Jaati of Sri Raag?", [
          "Audav-Sampooran",
          "Audav-Audav",
          "Shadav-Sampooran",
          "Sampooran-Sampooran",
        ], 0),
        _text("Which notes are Varjit in the Aroh of Sri Raag?",
            ["R and P", "G and D", "S and N", "M and P"], 1),
        _text("What is the Vaadee of Sri Raag?", ["R", "G", "P", "N"], 0),
        _text("What is the Samvaadee of Sri Raag?", ["S", "G", "P", "N"], 2),
        _text("What does “meend-pradhaan” mean?", [
          "The Raag uses only five notes",
          "The Raag emphasizes smooth glides between notes",
          "The Raag is traditionally sung at night",
          "The Raag contains no Komal notes",
        ], 1),
        _text("What is the general character of Sri Raag?", [
          "Joyful and playful",
          "Serious and introspective",
          "Excited and energetic",
          "Light and humorous",
        ], 1),
        _text("When is Sri Raag usually sung?",
            ["Spring", "Dawn", "Evening", "Fall"], 1),
        _pickRaag(scale, "Which audio example is Sri Raag?",
            ['kalyan aroh', 'gond aroh', 'bhairo aroh', 'sri aroh'], 3),
      ];

  // Raag Level 6 - Maru
  static List<Question> _maru(String scale) => [
        _text("Which Thaat does Raag Maru belong to?",
            ["Bilaval", "Todi", "Khamaj", "Kalyan"], 2),
        _text("What is the Jaati of Raag Maru?", [
          "Audav-Sampooran",
          "Shadav-Sampooran",
          "Sampooran-Sampooran",
          "Audav-Audav",
        ], 1),
        _text("Which note is Varjit in the Aroh of Maru?",
            ["G", "R", "D", "N"], 1),
        _text("What is the Aroh of Raag Maru?",
            ["SGMPDNS'", "SRGMPDNS'", "SGMPDS'", "SGMPNS'"], 0),
        _text("What makes the note structure of Maru especially complex?", [
          "It only uses five notes",
          "It uses both forms of M, D, and N",
          "It has no Varjit notes",
          "It uses only Komal notes",
        ], 1),
        _text("What is the Vaadee of Raag Maru?", ["S", "G", "P", "N"], 1),
        _text("What is the Samvaadee of Raag Maru?", ["S", "G", "N", "P"], 2),
        _text("What is the general character of Raag Maru?", [
          "Joyful and playful",
          "Strong and serious",
          "Peaceful and serene",
          "Light and humorous",
        ], 1),
        _text("What is the Mukh Ang of Raag Maru?", [
          "SGMP, DNS'",
          "PPnDP, mPdNdP, PDPG, R, GRS",
          "SnDP, NDP, MGRS",
          "mPDnDP, PDPGRS, RS",
        ], 1),
        _pickRaag(scale, "Which audio example is Raag Maru?",
            ['kalyan avroh', 'maru avroh', 'malhar avroh', 'sarang avroh'], 1),
      ];

  // ================================================================ SHUDH SUR

  // Sur Level 1 - Introduction to Sur + Sa (Shadaj)
  static List<Question> _sur1(String scale) => [
        _text("What is a Sur?",
            ["A musical note", "A rhythm pattern", "A type of Raag", "A tempo"], 0),
        _text("How many Shudh Surs are there in the basic Saptak (scale)?",
            ["12", "5", "7", "8"], 2),
        _text("Which of these is NOT a Sur in the Sargam system used in this course?",
            ["S", "Do", "N", "D"], 1),
        _text("What does “Shudh” mean?", [
          "Higher or sharper",
          "Lower or flatter",
          "Pure or natural",
          "Forbidden or omitted",
        ], 2),
        _text("What are the seven Shudh Surs?", [
          "S, G, M, P, D, N, S",
          "S, R, G, M, P, D, N",
          "S, R, M, P, D, N, S",
          "R, G, M, P, D, N, S",
        ], 1),
        _text("What is an Achala Sur?", [
          "A Sur that is always omitted",
          "A Sur that changes depending on the Raag",
          "A Sur that remains fixed and does not have a Vakrit form",
          "A Sur that is always sung higher",
        ], 2),
        _text("Which two Surs are Achala Surs?",
            ["R and G", "G and M", "S and P", "D and N"], 2),
        _text("What is the full name of S?",
            ["Shadaj", "Rishab", "Gandhar", "Pancham"], 0),
        _listen(scale, "What note/sargam is this?", 'S',
            ["R", "S", "P", "M"], 1),
        _pick(scale, "Which audio is S?", ['R', 'S', 'G', 'P'], 1),
      ];

  // Sur Level 2 - Re (Rishab)
  static List<Question> _sur2(String scale) => [
        _text("What is the full name of R?",
            ["Rishad", "R", "Rishab", "Rela"], 2),
        _text("Which Shudh Sur comes after S in the Saptak?",
            ["G", "R", "M", "P"], 1),
        _listen(scale, "What note/sargam is this?", 'R',
            ["R", "S", "P", "G"], 0),
        _listen(scale, "What note/sargam is this?", 'RRSS',
            ["RRSS", "SSRR", "RSRS", "SRSR"], 0),
        _listen(scale, "What note/sargam is this?", 'SRRRS',
            ["SRSRS", "SRRRS", "RSRRS", "SSRRS"], 1),
        _pick(scale, "Which audio is the sargam SRSRSR?",
            ['SSRSRR', 'RSSRSS', 'SRSRSR', 'RSRRRSRR'], 2),
        _listen(scale, "What do you hear?", 'SSRSRR',
            ["SSRSRS", "SSRSRR", "SRSSRR", "RSSRRS"], 1),
        _listen(scale, "What do you hear?", 'RSRRRSRR',
            ["RSRRSRSR", "RSRRRSRR", "SRRRSRRS", "RRSRRSRS"], 1),
        _pick(scale, "Which audio contains RSSRSS?",
            ['RSSRSS', 'SRSRSR', 'RRSS', 'SRRRS'], 0),
        _listen(scale, "What note/sargam is this?", 'SRRRS',
            ["SSRRS", "RSRRS", "SRRRS", "SRSRS"], 2),
      ];

  // Sur Level 3 - Ga (Gandhar)
  static List<Question> _sur3(String scale) => [
        _text("What is the full name of G?",
            ["Gandhar", "Gujri", "Gandhyam", "Gond"], 0),
        _text("Which note comes after R in the Saptak?",
            ["P", "S", "G", "M"], 2),
        _pick(scale, "Which audio is Ga?", ['R', 'G', 'S', 'M'], 1),
        _listen(scale, "What note/sargam is this?", 'GGRS',
            ["GRGS", "GGRS", "GGSR", "RGGS"], 1),
        _listen(scale, "What do you hear?", 'RGSRG',
            ["RGSRG", "RSGRG", "GRSRG", "RGSGR"], 0),
        _listen(scale, "What do you hear?", 'GSSRGGG',
            ["GSSSGGG", "GSSRGGG", "GGSRSGG", "SGSRGGG"], 1),
        _pick(scale, "Which audio is SGGRSRR?",
            ['SRGRGSGSRG', 'SGGRSRR', 'GGRS', 'RGSRG'], 1),
        _listen(scale, "What note/sargam is this?", 'RSRGRRSG',
            ["GSRGRRSG", "RSRGRRSG", "RRSGRSRG", "SRGRRSGR"], 1),
        _pick(scale, "Which audio is SRGRGSGSRG?",
            ['GSSRGGG', 'SGGRSRR', 'SRGRGSGSRG', 'GGRS'], 2),
        _listen(scale, "What do you hear?", 'GSSRGGG',
            ["GSSRGGG", "GGSRGSG", "GSRSGGG", "SGSRGGG"], 0),
      ];

  // Sur Level 4 - Ma (Madhyam)
  static List<Question> _sur4(String scale) => [
        _text("What is the full name of M?",
            ["Malhaar", "Madhyam", "Gandhar", "Mandar"], 1),
        _text("Which note comes directly before M in the Saptak?",
            ["P", "R", "G", "S"], 2),
        _listen(scale, "What note/sargam is this?", 'M',
            ["G", "M", "R", "P"], 1),
        _listen(scale, "What do you hear?", 'MMGGRRSS',
            ["MGGRRSS", "MMGGRRSS", "MMRRGGSS", "SSRRGGMM"], 1),
        _listen(scale, "What do you hear?", 'SRMGSRGS',
            ["SGRMSRGS", "SRMGSRGS", "SMRGSGRS", "RSMGRSGR"], 1),
        _pick(scale, "Which audio is RMMMGGR?",
            ['GSRMRS', 'RMMMGGR', 'MSRGRS', 'SRMGSRGS'], 1),
        _listen(scale, "What note/sargam is this?", 'GSRMRS',
            ["GSMGRS", "GSRMRS", "GRSMRS", "SGRMSR"], 1),
        _pick(scale, "Which audio is MSRGRS?",
            ['MSRGRS', 'RGMGMRMRGM', 'MMGGRRSS', 'SRMGSRGS'], 0),
        _listen(scale, "What do you hear?", 'RGMGMRMRGM',
            ["RSMGMSMRGM", "RGMGMRMRGM", "SGRMGMRGMR", "GRMGMRRMGM"], 1),
        _pick(scale, "Which audio is SRMGSRGS?",
            ['MMGGRRSS', 'SRMGSRGS', 'RMMMGGR', 'MSRGRS'], 1),
      ];

  // Sur Level 5 - Pa (Pancham)
  static List<Question> _sur5(String scale) => [
        _text("What is the full name of P?",
            ["Pancham", "Panchat", "Pritham", "Partaal"], 0),
        _text("What type of Sur is P?",
            ["Vakrit", "Achala", "Teevar", "Komal"], 1),
        _listen(scale, "What note/sargam is this?", 'P',
            ["M", "P", "S", "R"], 1),
        _listen(scale, "What do you hear?", 'SRGMP',
            ["PMGRS", "SRGMP", "SGRMP", "RGMSP"], 1),
        _listen(scale, "What note/sargam is this?", 'GPMGR',
            ["SPRGS", "GPMGR", "GMPGR", "RGPMG"], 1),
        _pick(scale, "Which audio is SGPGPS?",
            ['MPGSRMP', 'SGPGPS', 'RMPMRS', 'SRGMP'], 1),
        _listen(scale, "What do you hear?", 'MPGSRMP',
            ["MPGSRMP", "MGPSRMP", "MPGRSMP", "PMGSRPM"], 0),
        _pick(scale, "Which audio has RMPMRS?",
            ['RMPMRS', 'GMPMPGPGMP', 'GPMGR', 'SGPGPS'], 0),
        _listen(scale, "What is the highest note you hear?", 'GMPMPGPGMP',
            ["G", "P", "M", "R"], 1),
        _listen(scale, "What note/sargam is this?", 'GMPMPGPGMP',
            ["SMGMPMRGMP", "GMPMPGPGMP", "GPMPGMPGMP", "MGPMPGMPGM"], 1),
      ];

  // Sur Level 6 - Dha (Dhaivat)
  static List<Question> _sur6(String scale) => [
        _text("What is the full name of D?",
            ["Dhaivar", "Dhan", "Dhrupad", "Dhaivat"], 3),
        _text("What note comes after P in the Saptak?",
            ["M", "N", "D", "S"], 2),
        _listen(scale, "What note/sargam is this?", 'D',
            ["P", "M", "D", "R"], 2),
        _listen(scale, "What do you hear?", 'GMPDDP',
            ["GMPDPP", "GMPDDP", "GPMDPD", "MGPDDM"], 1),
        _pick(scale, "Which audio contains RMPDS'DP?",
            ["DDPDMRGMP", "RMPDS'DP", "SMGPMDP", "GMPDDP"], 1),
        _listen(scale, "What do you hear?", 'MGRSGPD',
            ["MRPSGPD", "MGRSGPD", "MRGSPGD", "GMRSGDP"], 1),
        _listen(scale, "How many distinct notes do you hear?", 'DDPDMRGMP',
            ["5", "6", "7", "4"], 0),
        _listen(scale, "What do you hear?", 'SMGPMDP',
            ["SPMGMDP", "SMGPMDP", "SGMPDMP", "MSGPMDS"], 1),
        _pick(scale, "Which audio is MPDPDMDMPD?",
            ['GMPDDP', 'MGRSGPD', 'MPDPDMDMPD', 'SMGPMDP'], 2),
        _listen(scale, "What note/sargam is this?", 'DDPDMRGMP',
            ["MDPMRSGMP", "DDPDMRGMP", "DPDMRGMPD", "PDDMRGPM"], 1),
      ];

  // Sur Level 7 - Ni (Nishad)
  static List<Question> _sur7(String scale) => [
        _text("What is the full name of N?",
            ["Naam", "Nishad", "Nitnem", "Nidhar"], 1),
        _text("What note comes after D in the Saptak?",
            ["S", "P", "N", "M"], 2),
        _listen(scale, "What note/sargam is this?", 'N',
            ["D", "N", "P", "M"], 1),
        _listen(scale, "Choose the correct order of notes you hear.",
            "SRMPNDS'", ["SRMPNDS'", "DNPMGMRS", "GMRSRMPN", "PDNMNNS'"], 0),
        _listen(scale, "How many times do you hear N in this sequence?",
            "NNNS'DDPP", ["2", "3", "4", "1"], 1),
        _listen(scale, "What do you hear?", "NS'DPMRS",
            ["NR'S'DPMP", "NS'DPMRS", "NDS'PMRS", "S'NDPMRS"], 1),
        _pick(scale, "Which audio is SRMPNDS'?",
            ["NNNS'DDPP", "SRMPNDS'", 'GMPDNDNDP', 'MDNNNDGMG'], 1),
        _listen(scale, "What do you hear?", 'GMPDNDNDP',
            ["GMRGDNDPS'", "GMPDNDNDP", "GPMDNDPNS'", "MGPDNPDND"], 1),
        _pick(scale, "Which audio is PDNDNPNPDN?",
            ["NS'DPMRS", 'MDNNNDGMG', 'PDNDNPNPDN', "SRMPNDS'"], 2),
        _listen(scale, "What do you hear?", 'MDNNNDGMG',
            ["MDNNNNMGG", "MDNNNDGMG", "MNDNNGDMG", "DMNNDGMGN"], 1),
      ];

  // =============================================================== VAKRIT SUR

  // Vakrit Sur Level 1 - Introduction to Vakrit Sur + Komal Re
  static List<Question> _vakrit1(String scale) => [
        _text("What are the two types of Vakrit Surs?", [
          "Komal and Teevar",
          "Rishab and Gandhar",
          "Vaadee and Samvaadee",
          "Varjit Sur and Achala Sur",
        ], 0),
        _text("What is a Komal Sur?", [
          "A higher or sharper variation of a Shudh Sur",
          "A lower or flatter variation of a Shudh Sur",
          "A forbidden Sur",
          "An Achala Sur",
        ], 1),
        _text("Which four Surs have Komal forms?", [
          "S, G, M, P",
          "R, G, D, N",
          "S, P, D, N",
          "R, M, P, N",
        ], 1),
        _text("Which Sur represents Komal Re?", ["R", "r", "M", "n"], 1),
        _listen(scale, "What note/sargam is this?", 'r',
            ["R", "r", "G", "S"], 1),
        _listen(scale, "What do you hear?", 'SrGrrS',
            ["SRGRRS", "SrGrrS", "SRGRSRS", "SrSGRS"], 1),
        _pick(scale, "Which audio is SRGMrrSrr?",
            ['rPPMGr', 'SRGMrrSrr', 'RSGPGr', 'DPGrS'], 1),
        _listen(scale, "What do you hear?", 'rPPMGr',
            ["rMMPGR", "rPPMGr", "RmMMGR", "rPMPGR"], 1),
        _listen(scale, "What note/sargam is this?", 'DPGrS',
            ["DPGRS", "DPGrS", "DrGPS", "PGrSD"], 1),
        _pick(scale, "Which audio contains rGMGMrMrGM?",
            ['rPPMGr', 'RSGPGr', 'SRGMrrSrr', 'rGMGMrMrGM'], 3),
      ];

  // Vakrit Sur Level 2 - Komal Ga
  static List<Question> _vakrit2(String scale) => [
        _text("What is Komal Ga?", [
          "A higher variation of G",
          "A lower or flatter variation of G",
          "An Achala Sur",
          "Another name for P",
        ], 1),
        _text("How is Komal Ga commonly notated in the Sargam system used in this course?",
            ["G", "g", "m", "d"], 1),
        _listen(scale, "What note/sargam is this?", 'g',
            ["G", "g", "r", "M"], 1),
        _listen(scale, "What do you hear?", 'ggrgrS',
            ["ggrgrS", "GGRGRS", "gRGRS", "RgRGS"], 0),
        _pick(scale, "Which audio is gMPMgRS?",
            ["PgMRS'", 'gMPMgRS', 'PGrSggMP', 'gMDPMgRS'], 1),
        _listen(scale, "What do you hear?", "PgMRS'",
            ["PGMRS'", "PgMRS'", "PGRMS'", "gPMRS'"], 1),
        _listen(scale, "What note/sargam is this?", 'PGrSggMP',
            ["PGRSGGMP", "PGrSggMP", "PRGSGGMP", "PgSRGMP"], 1),
        _pick(scale, "Which audio is gMDPMgRS?",
            ['gMDPMgRS', 'SRgRgSgSRg', 'ggrgrS', "PgMRS'"], 0),
        _listen(scale, "What do you hear?", 'SRgRgSgSRg',
            ["SRGRGSGSRG", "SRgRgSgSRg", "SrGRSGRG", "RSgRGSRG"], 1),
        _pick(scale, "Which audio contains gMPMgRS?",
            ['ggrgrS', 'gMPMgRS', 'PGrSggMP', 'SRgRgSgSRg'], 1),
      ];

  // Vakrit Sur Level 3 - Teevar Ma
  static List<Question> _vakrit3(String scale) => [
        _text("What is Teevar Ma?", [
          "A lower variation of M",
          "A higher or sharper variation of M",
          "An Achala Sur",
          "Another name for P",
        ], 1),
        _text("How is Teevar Ma notated in the Sargam system used in this course?",
            ["M", "m", "d", "g"], 1),
        _listen(scale, "What note/sargam is this?", 'm',
            ["M", "m", "g", "P"], 1),
        _listen(scale, "What do you hear?", 'SRmmPDP',
            ["SRMMPDP", "SRmmPDP", "SRMPMDP", "RSmMPD"], 1),
        _pick(scale, "Which audio is mGPmGrS?",
            ['GmPmGrS', 'mGPmGrS', 'MGPmDPP', 'mmmDNNNDNP'], 1),
        _listen(scale, "What do you hear?", 'GmPmGrS',
            ["GMPMGRS", "GmPmGrS", "GPMGMRS", "mGPMGRS"], 1),
        _listen(scale, "What note/sargam is this?", 'MGPmDPP',
            ["MGPMDPP", "MGPmDPP", "MPGMDPP", "MGmPDP"], 1),
        _pick(scale, "Which audio contains mmmDNNNDNP?",
            ['SRmmPDP', 'mGPmGrS', 'mmmDNNNDNP', 'GmPmPGPGmP'], 2),
        _listen(scale, "What do you hear?", 'GmPmPGPGmP',
            ["GMPMPGPGMP", "GmPmPGPGmP", "GPMPGMPGMP", "mGPMPGPMP"], 1),
        _pick(scale, "Which audio is SRmmPDP?",
            ['SRmmPDP', 'MGPmDPP', 'GmPmGrS', 'GmPmPGPGmP'], 0),
      ];

  // Vakrit Sur Level 4 - Komal Dha
  static List<Question> _vakrit4(String scale) => [
        _text("What is Komal Dha?", [
          "A higher variation of D",
          "A lower or flatter variation of D",
          "An Achala Sur",
          "Another name for N",
        ], 1),
        _text("How is Komal Dha notated in the Sargam system used in this course?",
            ["D", "d", "n", "m"], 1),
        _listen(scale, "What note/sargam is this?", 'd',
            ["D", "d", "r", "N"], 1),
        _listen(scale, "What do you hear?", 'rgrPmdP',
            ["rGRPMdP", "rgrPmdP", "RGRPMDP", "rGPMdR"], 1),
        _pick(scale, "Which audio is ddPdddMPGM?",
            ["mdNS'Nr'S'", 'ddPdddMPGM', 'gmdNdmgrS', 'RMPdNdP'], 1),
        _listen(scale, "What do you hear?", "mdNS'Nr'S'",
            ["MdNS'NR'S'", "mdNS'Nr'S'", "MDNS'RNS'", "mdNS'NR'S'"], 1),
        _listen(scale, "What note/sargam is this?", 'gmdNdmgrS',
            ["GMDNDMGRS", "gmdNdmgrS", "GmDNDGRS", "GMDnDMGRS"], 1),
        _pick(scale, "Which audio is RMPdNdP?",
            ['RMPdNdP', 'MPdPdMdMPd', 'rgrPmdP', 'gmdNdmgrS'], 0),
        _listen(scale, "What do you hear?", 'MPdPdMdMPd',
            ["MPDPDMDMP", "MPdPdMdMPd", "MdPDMPMD", "PMdPMDMP"], 1),
        _pick(scale, "Which audio contains gmdNdmgrS?",
            ['ddPdddMPGM', 'RMPdNdP', 'gmdNdmgrS', 'MPdPdMdMPd'], 2),
      ];

  // Vakrit Sur Level 5 - Komal Ni
  static List<Question> _vakrit5(String scale) => [
        _text("What is Komal Ni?", [
          "A higher variation of N",
          "A lower or flatter variation of N",
          "An Achala Sur",
          "Another name for S",
        ], 1),
        _text("How is Komal Ni notated in the Sargam system used in this course?",
            ["N", "n", "d", "g"], 1),
        _listen(scale, "What note/sargam is this?", 'n',
            ["N", "n", "D", "S"], 1),
        _listen(scale, "What do you hear?", "NS'NS'DnDn",
            ["NS'NS'DNDN", "NS'NS'DnDn", "NS'DNS'DN", "S'NS'NDNDN"], 1),
        _pick(scale, "Which audio is nDNS'DnP?",
            ['GMDnnDPP', "nDNS'DnP", 'RMPnnPnnnPMP', 'DGMPnDP'], 1),
        _listen(scale, "What do you hear?", 'GMDnnDPP',
            ["GMDNNDPP", "GMDnnDPP", "GMdNNPP", "GDMnDPP"], 1),
        _listen(scale, "What note/sargam is this?", 'RMPnnPnnnPMP',
            ["RMPNNPNNNPMP", "RMPnnPnnnPMP", "RPMNPNNPMP", "RMPdnPNPMP"], 1),
        _pick(scale, "Which audio is DGMPnDP?",
            ['DGMPnDP', 'PDnDnPnPDn', "NS'NS'DnDn", "nDNS'DnP"], 0),
        _listen(scale, "What do you hear?", 'PDnDnPnPDn',
            ["PDnPnPnPDn", "PDnDnPnPDn", "PdNDNPNDN", "DPnDPNDn"], 1),
        _pick(scale, "Which audio contains nDNS'DnP?",
            ['GMDnnDPP', "nDNS'DnP", 'DGMPnDP', 'PDnDnPnPDn'], 1),
      ];
}
