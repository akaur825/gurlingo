// lib/data/raag_lesson_content.dart
//
// All the teaching content for the Raag lessons. One entry per lesson, keyed by the
// lesson id used in lesson_data.dart. To change a lesson, edit its text here.
//
// Notation: S R G M P D N are Shudh. r g d n are Komal. m is Teevar Ma.
// S' is the upper Sa. Ṇ is N in the lower octave (dot below, as in the book).

import 'package:flutter/material.dart';

/// Splits a phrase like "ṆRG" or "NS'" into single notes: [Ṇ, R, G] or [N, S'].
List<String> splitNotes(String phrase) {
  final matches = RegExp("[SRGMPDNsrgmpdnṆ]'?").allMatches(phrase);
  return matches.map((m) => m.group(0)!).toList();
}

class RaagQuote {
  final String gurmukhi;
  final String meaning;
  final String source;

  RaagQuote({
    required this.gurmukhi,
    required this.meaning,
    required this.source,
  });
}

class RaagLessonContent {
  final String name;
  final String tagline;
  final IconData icon;
  final String audioKey; // used in the audio file names, e.g. G_bilaval_aroh.mp3
  final String raagNumber;
  final String ang;

  final String thaat;
  final String jaati;
  final String jaatiMeaning;
  final String time;
  final String? season;
  final String mood;

  final String vaadee;
  final String vaadeeName;
  final String samvaadee;
  final String samvaadeeName;

  final List<String> aroh; // phrases, e.g. ['S', 'RG', 'MP']
  final String arohNote;
  final List<String> avroh;
  final String avrohNote;
  final List<String> mukhAng;
  final String mukhAngNote;

  // For each of the 7 positions: which forms the Raag uses. An empty list means
  // the note is Varjit (not used at all).
  final Map<String, List<String>> noteForms;
  final List<String> varjitAroh;
  final List<String> varjitAvroh;

  final List<String> story;
  final List<String> listenFor;
  final List<RaagQuote> quotes;
  final String exampleShabad;
  final List<String> didYouKnow;
  final List<String> remember;

  RaagLessonContent({
    required this.name,
    required this.tagline,
    required this.icon,
    required this.audioKey,
    required this.raagNumber,
    required this.ang,
    required this.thaat,
    required this.jaati,
    required this.jaatiMeaning,
    required this.time,
    this.season,
    required this.mood,
    required this.vaadee,
    required this.vaadeeName,
    required this.samvaadee,
    required this.samvaadeeName,
    required this.aroh,
    required this.arohNote,
    required this.avroh,
    required this.avrohNote,
    required this.mukhAng,
    required this.mukhAngNote,
    required this.noteForms,
    this.varjitAroh = const [],
    this.varjitAvroh = const [],
    required this.story,
    required this.listenFor,
    this.quotes = const [],
    required this.exampleShabad,
    this.didYouKnow = const [],
    this.remember = const [],
  });
}

/// All seven notes as Shudh, then apply the changes for one Raag.
Map<String, List<String>> _forms([Map<String, List<String>> changes = const {}]) {
  final base = <String, List<String>>{
    'S': ['S'],
    'R': ['R'],
    'G': ['G'],
    'M': ['M'],
    'P': ['P'],
    'D': ['D'],
    'N': ['N'],
  };
  base.addAll(changes);
  return base;
}


final Map<String, RaagLessonContent> raagLessonContents = {
  // ------------------------------------------------------ INTRODUCTION TO RAAG
  'raag-1': RaagLessonContent(
    name: 'Introduction to Raag',
    tagline: 'Understanding the language of Raag',
    icon: Icons.music_note,
    audioKey: '',
    raagNumber: 'Introduction',
    ang: 'Overview',
    thaat: 'Parent scale or framework',
    jaati: 'Audav, Shadav and Sampooran',
    jaatiMeaning: 'The number of notes used in ascending and descending movements',
    time: 'Not applicable',
    mood: 'Every Raag has its own musical character and emotion',
    vaadee: 'Vadi',
    vaadeeName: 'The most prominent note',
    samvaadee: 'Samvadi',
    samvaadeeName: 'The second most important note',
    aroh: ['S', 'R', 'G', 'M', 'P', 'D', 'N', "S'"],
    arohNote: 'Aroh is the ascending movement of a Raag.',
    avroh: ["S'", 'N', 'D', 'P', 'M', 'G', 'R', 'S'],
    avrohNote: 'Avroh is the descending movement of a Raag.',
    mukhAng: [],
    mukhAngNote: 'Characteristic phrases that help identify a Raag.',
    noteForms: _forms(),
    story: [
      'Waheguru Ji Ka Khalsa, Waheguru Ji Ki Fateh.',
      'Before we learn individual Raags, we need to understand the basic terms used to describe them.',
      'Let’s start with the most important question: what exactly is a Raag?',
      'A Raag is a set of notes ascending and descending a scale that provokes a specific emotion. A Raag is much more than just a musical scale because two Raags can use many of the same notes but still sound completely different because they use those notes in different ways.',
      'In Gurmat Sangeet, Raag is especially important because Sri Guru Granth Sahib Ji is organized primarily according to Raags. There are 31 Shudh Raags in Sri Guru Granth Sahib Ji, along with various mixed or Mishrat Raags, but here, we will be focusing primarily on Shudh Raags.',
      'When studying a Raag, we are not just memorizing which notes belong to it. We are learning how those notes move, which notes are important, which phrases identify them, and how the Raag creates its own musical character.',
      'Let’s start with the movement of the notes. The ascending movement of a Raag is called the Aroh. For example, in a simple seven-note scale, we might have Sa, Re, Ga, Ma, Pa, Dha, Ni, Sa. That is the Aroh — the upward movement.',
      'The descending movement is called the Avroh. We would come back down: Sa, Ni, Dha, Pa, Ma, Ga, Re, Sa.',
      'But here is something important: the Aroh and Avroh of a Raag do not always simply go straight up and straight down. A Raag may skip certain notes, repeat notes, change direction, or use a particular combination of notes. That is one of the reasons why Raags can have such distinct identities.',
      'Now that we understand how the notes move, let’s talk about the notes that are especially important within a Raag.',
      'The most prominent note is called the Vadi sur. You can think of the Vadi as the main or most important note of the Raag. The second most important note is called the Samvadi sur. The relationship between the Vadi and Samvadi helps give the Raag its particular character.',
      'After the Vadi and Samvadi, we have the Anuvadi notes. These are the other notes that are permitted and used within the Raag, but they are not as prominent as the Vadi and Samvadi.',
      'The final category of notes we need to understand in a Raag are Varjit notes. Varjit means forbidden or omitted. A note can be Varjit from a particular movement of the Raag. For example, if a note is Varjit in the Aroh, that note is not used while ascending. If it is Varjit in the Avroh, it is not used while descending. This is important because not every Raag uses all seven notes in both directions.',
      'This brings us to the idea of Jaati. Jaati describes the number of notes used in the Aroh and Avroh of a Raag. There are three basic categories: Audav means five notes, Shadav means six notes, and Sampooran means seven notes.',
      'Because the Aroh and Avroh can use different numbers of notes, these categories can be used in various combinations. For example, Audav-Sampooran means five notes in the Aroh and seven notes in the Avroh. Shadav-Audav means six notes in the Aroh and five notes in the Avroh. So when you see the Jaati of a Raag, it gives you an immediate idea of how many notes are being used in its ascending and descending movements.',
      'Now that we understand the individual notes and the structure of those notes, we can zoom out and look at a larger classification system: Thaat. A Thaat is a parent scale or framework used to classify Raags. You can think of a Thaat as a larger family of notes, and individual Raags as different ways of arranging and using those notes. Raags in the same Thaat can share the same basic set of notes but still have completely different identities because their Aroh, Avroh, Vadi, Samvadi, and other features can be different.',
      'Finally, we have one of the most useful concepts for actually recognizing a Raag. Mukh Ang means the characteristic or identifying phrases of a Raag. These are specific combinations or movements of notes that help give a Raag its recognizable sound.',
      'Once you understand these terms, the information in the rest of this series will make a lot more sense. We are not trying to memorize every Raag yet. We are learning how to look at a Raag, understand its structure, and listen for what makes it unique.',
      'Waheguru Ji Ka Khalsa, Waheguru Ji Ki Fateh.',
    ],
    listenFor: [
      'Aroh is the ascending movement of notes.',
      'Avroh is the descending movement of notes.',
      'Vadi is the most prominent note; Samvadi is the second most important.',
      'Varjit notes are omitted in a particular movement.',
      'Jaati tells us how many notes are used going up and coming down.',
      'Thaat is the parent scale or framework.',
      'Mukh Ang contains the characteristic phrases that help identify a Raag.',
    ],
    exampleShabad: 'Introduction to the concepts used to understand Raags.',
    remember: [
      'Aroh: ascending movement',
      'Avroh: descending movement',
      'Vadi: most prominent note',
      'Samvadi: second most important note',
      'Anuvadi: other permitted notes',
      'Varjit: omitted notes',
      'Jaati: number of notes in Aroh and Avroh',
      'Thaat: parent scale or framework',
      'Mukh Ang: characteristic phrases of a Raag',
    ],
  ),

  // ---------------------------------------------------------------- BILAVAL
  'raag-2': RaagLessonContent(

    name: 'Raag Bilaval',
    tagline: 'The Raag of joy and contentment',
    icon: Icons.wb_sunny_outlined,
    audioKey: 'bilaval',
    raagNumber: '16th Raag',
    ang: 'Ang 795',
    thaat: 'Bilaval',
    jaati: 'Sampooran-Sampooran',
    jaatiMeaning: '7 notes going up, 7 coming down',
    time: 'Second quarter of the day (about 9 AM to 12 PM)',
    mood: 'Joy and contentment',
    vaadee: 'D',
    vaadeeName: 'Dhaivat',
    samvaadee: 'G',
    samvaadeeName: 'Gandhar',
    aroh: ['S', 'RG', 'MP', 'D', "NS'"],
    arohNote: 'All seven notes, straight up the scale.',
    avroh: ["S'ND", 'P', 'MG', 'RS'],
    avrohNote: 'All seven notes, straight back down.',
    mukhAng: ['GR', 'GPDP', 'MG', 'MRS'],
    mukhAngNote: 'One of the phrases that helps us recognize Bilaval when we hear it.',
    noteForms: _forms(),
    story: [
      "Did you know that Raag Bilaval is known for its feeling of joy and happiness? But the joy in Bilaval is more than just being happy. It can also be connected to feeling content with what Waheguru has given us.",
      "Bilaval is a prominent and basic Raag of both Indian classical music and Gurmat Sangeet. It is the 16th Raag in Sri Guru Granth Sahib Ji, starting on Ang 795. It is built entirely on the Shudh Saptak, so it uses all seven Shudh Surs: S R G M P D N.",
      "It comes from the Bilaval Thaat, the same Thaat that Gond and Basant belong to. Its Jaati is Sampooran-Sampooran: seven notes going up and seven coming down. There are no Varjit notes. It is traditionally sung in the second quarter of the day, from around 9 AM to 12 PM.",
      "The Vaadee is D and the Samvaadee is G. The other notes (S, R, M, P and N) are the Anuvaadee notes.",
    ],
    listenFor: [
      "Every note is Shudh, so Bilaval sounds like the plain, natural scale.",
      "Listen for the phrase GR, GPDP, MG, MRS. It is the Mukh Ang of Bilaval.",
    ],
    quotes: [
      RaagQuote(
        gurmukhi: 'ਜੋ ਤੁਧੁ ਭਾਵੈ ਸੋਈ ਚੰਗਾ',
        meaning:
            "Whatever pleases You is good. This fits Bilaval really well, because true happiness doesn't always mean getting what we want. It can also mean learning to be content with Waheguru's Hukam.",
        source: 'Guru Nanak Dev Ji',
      ),
    ],
    exampleShabad: 'Bilaval Mahalaa 5, Ang 827: "Mai naahee prabh sabh kichh teraa"',
    didYouKnow: [
      "There are over 170 Shabads in Bilaval in Sri Guru Granth Sahib Ji, so it is used quite a lot.",
    ],
    remember: [
      'No Varjit notes: all seven notes are used',
    ],
  ),

  // ---------------------------------------------------------------- BASANT
  'raag-3': RaagLessonContent(
    name: 'Raag Basant',
    tagline: 'The Raag of spring and renewal',
    icon: Icons.local_florist,
    audioKey: 'basant',
    raagNumber: '25th Raag',
    ang: 'Ang 1168',
    thaat: 'Bilaval',
    jaati: 'Audav-Sampooran',
    jaatiMeaning: '5 notes going up, 7 coming down',
    time: 'Second quarter of the day, and any time in the Basant season',
    season: 'After Lohri, from Maghi until Hola Mohalla (spring, the month of Basant)',
    mood: 'Inner rejuvenation and a fresh start',
    vaadee: 'S',
    vaadeeName: 'Shadaj',
    samvaadee: 'M',
    samvaadeeName: 'Madhyam',
    aroh: ['SGM', "DNS'"],
    arohNote: 'Only five notes going up. R and P are Varjit in the Aroh.',
    avroh: ["S'NDPM", 'GRS'],
    avrohNote: 'All seven notes come back on the way down.',
    mukhAng: ["GMDNS'", "S'NDPM", 'G', 'RS'],
    mukhAngNote: 'This gives Basant its recognizable movement.',
    noteForms: _forms(),
    varjitAroh: ['R', 'P'],
    story: [
      "Did you know that there is a Raag that literally translates to spring? It is Raag Basant! It is the 25th Raag in Sri Guru Granth Sahib Ji, beginning on Ang 1168.",
      "Basant is a seasonal melody. In Gurmat Sangeet tradition it is sung after Lohri, from Maghi (the Sangraand of Maagh) until Hola Mohalla, during spring or the month of Basant, and it is included in every Keertan programme in that season. It can also be sung in the second quarter of the day.",
      "But in Gurmat Sangeet, Basant isn't only about the season changing. Just as spring brings new life after winter, Basant can represent an internal rejuvenation, a fresh start within ourselves.",
      "Basant comes from the Bilaval Thaat, and all of its notes are Shudh. Its Jaati is Audav-Sampooran: five notes going up and all seven coming back down. The Vaadee is S and the Samvaadee is M.",
      "Something interesting about the Aroh: R and P are left out. We say R and P are Varjit in the Aroh. That gives Basant its distinct movement.",
    ],
    listenFor: [
      "Going up, there is no R and no P. Only five notes are used.",
      "Coming down, all seven notes return.",
    ],
    quotes: [
      RaagQuote(
        gurmukhi:
            'ਸਾਂਤਿ ਸਹਜੁ ਗ੍ਰਿਹਿ ਸਦ ਬਸੰਤੁ ॥\nਗੁਰ ਪੂਰੇ ਕੀ ਸਰਣੀ ਆਏ ਕਲਿਆਣ ਰੂਪ ਜਪਿ ਹਰਿ ਹਰਿ ਮੰਤੁ ॥ ਰਹਾਉ ॥',
        meaning:
            "\"Sad basant\" means everlasting spring. It isn't talking about the weather. It describes a state of peace and inner balance. So Basant is a really nice metaphor for rejuvenating ourselves internally, just like the world around us is renewed during spring.",
        source: 'Sri Guru Granth Sahib Ji',
      ),
    ],
    exampleShabad: 'Basant Mahalaa 3, Ang 1176: "Tin basant jo har gunh gaa-e"',
    didYouKnow: [
      "Basant doesn't only appear in its pure form. Sri Guru Granth Sahib Ji also has mishrat (mixed) forms of the Raag, including Basant Hindol.",
    ],
    remember: [
      'Basant literally means spring',
      'R and P are Varjit in the Aroh',
      'Sung after Lohri, during spring or the month of Basant',
      'Mixed form: Basant Hindol',
    ],
  ),

  // ---------------------------------------------------------------- KALYAN
  'raag-4': RaagLessonContent(
    name: 'Raag Kalyan',
    tagline: 'Peace, serenity and inner balance',
    icon: Icons.nightlight_round,
    audioKey: 'kalyan',
    raagNumber: '29th Raag',
    ang: 'Ang 1319 to 1327',
    thaat: 'Kalyan',
    jaati: 'Sampooran-Sampooran',
    jaatiMeaning: '7 notes going up, 7 coming down',
    time: 'First quarter of the night',
    mood: 'Peace, serenity and inner balance',
    vaadee: 'G',
    vaadeeName: 'Gandhar',
    samvaadee: 'N',
    samvaadeeName: 'Nishad',
    aroh: ['ṆRG', 'mP', 'mD', "NS'"],
    arohNote: 'Starts from the lower-octave N (Ṇ). Teevar M (m) appears twice.',
    avroh: ["S'NDP", 'mG', 'RṆRS'],
    avrohNote: 'm shows up again on the way down.',
    mukhAng: ['ṆRG', 'GRGmPR', 'ṆRS'],
    mukhAngNote:
        "Don't just listen for m by itself. Listen to how it is approached inside these phrases.",
    noteForms: _forms({'M': ['m']}),
    story: [
      "If you've ever learned Hindustani classical music, Raag Kalyan might already sound familiar. That's because Kalyan is nearly identical to Raag Yaman, one of the most well-known Raags in Hindustani classical music.",
      "Kalyan is a prominent and basic Raag of the Gurmat tradition. It is the 29th Raag in Sri Guru Granth Sahib Ji, beginning on Ang 1319 and continuing to Ang 1327. It comes from the Kalyan Thaat, has a Sampooran-Sampooran Jaati, and is traditionally sung during the first quarter of the night.",
      "In this Raag every note is Shudh except one: Madhyam is Teevar. We write Teevar Ma as m. Because everything else is Shudh, m immediately stands out and plays a huge role in giving Kalyan its recognizable sound.",
      "The Vaadee is G and the Samvaadee is N. Kalyan has a feeling of peace, serenity and inner balance.",
      "A note about the notation: Ṇ means the N in the lower octave (the dot sits underneath).",
    ],
    listenFor: [
      "Listen for m, the sharper Teevar Ma. It is the only note that is not Shudh.",
      "Notice how m is approached within the phrases. That is what gives Kalyan its identity.",
    ],
    quotes: [
      RaagQuote(
        gurmukhi: 'ਹਰ ਚਰਣ ਸਰਨ ਕਲਿਆਨ ਕਰਨ ॥',
        meaning:
            "Even the word \"Kalyan\" itself carries the idea of well-being or blessedness, which makes the name and character of this Raag especially interesting.",
        source: 'Raag Kalyan',
      ),
    ],
    exampleShabad: 'Kalyan Mahalaa 4, Ang 1324: "Raam gur paaras pars kareejai"',
    remember: [
      'Closely connected to Raag Yaman in Hindustani classical music',
      'Listen for Teevar M (m). All the other notes are Shudh',
    ],
  ),

  // ---------------------------------------------------------------- BHAIRO
  'raag-5': RaagLessonContent(
    name: 'Raag Bhairo',
    tagline: 'Pensive, serious and ancient',
    icon: Icons.wb_twilight,
    audioKey: 'bhairo',
    raagNumber: '24th Raag',
    ang: 'Ang 1125 to 1168',
    thaat: 'Bhairav',
    jaati: 'Sampooran-Sampooran',
    jaatiMeaning: '7 notes going up, 7 coming down',
    time: 'Dawn, before sunrise',
    mood: 'Pensive and serious',
    vaadee: 'd',
    vaadeeName: 'Komal Dhaivat',
    samvaadee: 'r',
    samvaadeeName: 'Komal Rishab',
    aroh: ['Sr', 'GMP', 'd', "NS'"],
    arohNote: 'Both Komal notes (r and d) appear on the way up.',
    avroh: ["S'NddP", 'GMrr', 'S'],
    avrohNote: 'r and d are repeated on the way down.',
    mukhAng: ['GMddP', 'GMrrS'],
    mukhAngNote: 'The same two Komal notes keep coming back.',
    noteForms: _forms({'R': ['r'], 'D': ['d']}),
    story: [
      "You've reached one of the oldest Raags we will study: Raag Bhairo. It is a Raag of pensive mood and incomparable melodious nature.",
      "Bhairo is the 24th Raag in Sri Guru Granth Sahib Ji. It begins on Ang 1125 and continues to Ang 1168. It comes from the Bhairav Thaat, has a Sampooran-Sampooran Jaati, and is traditionally sung at dawn, before sunrise.",
      "Look at the notes and ask yourself: which ones are different? In Bhairo, it is R and D. Both are Komal, written r and d, while all the other notes are Shudh.",
      "The Vaadee is Komal D (d) and the Samvaadee is Komal R (r). Notice how those same two Komal notes keep coming back in the Mukh Ang. They are a huge part of Bhairo's identity.",
      "There is another detail that is harder to show on a scale: the treatment of the notes matters. Bhairo is known for the distinctive way r and d are approached and ornamented, and that gives it its serious character, beyond its Aroh and Avroh.",
    ],
    listenFor: [
      "Listen for r and d. They are the lower, flatter versions of R and D.",
      "Pay attention to how r and d are approached and ornamented, not only which notes are used.",
    ],
    exampleShabad: 'Bhairao Mahalaa 5, Ang 1142: "Satgur meraa bemuhtaaj"',
    didYouKnow: [
      "Bhairo is a very old Raag with an important place in both Gurmat Sangeet and Hindustani classical music, where it is known as Bhairav.",
    ],
    remember: [
      'Komal notes: r and d. All the others are Shudh',
      'Known as Bhairav in Hindustani classical music',
      'The treatment and ornamentation of r and d give Bhairo its serious character',
    ],
  ),

  // ---------------------------------------------------------------- TODI
  'raag-6': RaagLessonContent(
    name: 'Raag Todi',
    tagline: 'Reflective and introspective',
    icon: Icons.self_improvement,
    audioKey: 'todi',
    raagNumber: '12th Raag',
    ang: 'Ang 711 to 719',
    thaat: 'Todi',
    jaati: 'Sampooran-Sampooran',
    jaatiMeaning: '7 notes going up, 7 coming down',
    time: 'Second quarter of the day (late morning)',
    mood: 'Introspective and reflective',
    vaadee: 'd',
    vaadeeName: 'Komal Dhaivat',
    samvaadee: 'g',
    samvaadeeName: 'Komal Gandhar',
    aroh: ['Srg', 'mPmd', "NS'"],
    arohNote: 'Three Komal notes (r, g, d) and Teevar m.',
    avroh: ["S'Nd", 'P', 'mg', 'rS'],
    avrohNote: 'The same altered notes, coming back down.',
    mukhAng: ['dNS', 'rg', 'mgrg', 'rS'],
    mukhAngNote: 'Notice how often r and g appear together.',
    noteForms: _forms({'R': ['r'], 'G': ['g'], 'M': ['m'], 'D': ['d']}),
    story: [
      "We've talked a lot about how Raags can create different emotions, but can listening to a Raag actually have a measurable effect on the mind? That's something researchers have explored with Raag Todi.",
      "Todi is a time-honoured Raag, very popular with artists and audiences alike. It is the 12th Raag in Sri Guru Granth Sahib Ji, beginning on Ang 711 and continuing to Ang 719. It comes from the Todi Thaat (called Torhee in Indian classical music), has a Sampooran-Sampooran Jaati, and is traditionally sung in the second quarter of the day, in the late morning.",
      "Todi has a really recognizable combination of notes. Besides S and P, three notes are Komal: r, g and d. M is Teevar, written m, and N is Shudh. Those four altered notes (r, g, d and m) are what give Todi its identity.",
      "The Vaadee is d (Komal D) and the Samvaadee is g (Komal G). Todi has a very introspective and reflective character.",
      "And here's the part that is really interesting: Todi has actually been studied in music-therapy research. In one small study at the Amity Institute of Psychology and Allied Sciences and the Behavioral and Social Sciences of Manav Rachna International University, researchers had young adults listen to instrumental Raag Todi and found lower state-anxiety scores after listening.",
      "That doesn't mean Todi itself is a medical treatment, but the reflective quality associated with the Raag has made it a subject of research into music and the mind.",
    ],
    listenFor: [
      "Listen for the four altered notes: r, g, d and m.",
      "Notice d and g, the two most important notes in the Raag.",
    ],
    exampleShabad: 'Todi Mahalaa 4, Ang 711: "Har bin reh na sakai man meraa"',
    remember: [
      'Komal notes: r, g, d. Teevar note: m',
      'Studied in music-therapy research: lower state-anxiety scores after listening',
    ],
  ),

  // ---------------------------------------------------------------- SARANG
  'raag-7': RaagLessonContent(
    name: 'Raag Sarang',
    tagline: 'Only five notes, and a cooling feeling',
    icon: Icons.light_mode,
    audioKey: 'sarang',
    raagNumber: '26th Raag',
    ang: 'Ang 1197 to 1254',
    thaat: 'Kafi',
    jaati: 'Audav-Audav',
    jaatiMeaning: '5 notes going up, 5 coming down',
    time: 'Third quarter of the day (around midday)',
    mood: 'Spiritual fulfillment',
    vaadee: 'R',
    vaadeeName: 'Rishab',
    samvaadee: 'P',
    samvaadeeName: 'Pancham',
    aroh: ['S', 'RM', "PNS'"],
    arohNote: 'Five notes. G and D are Varjit.',
    avroh: ["S'nP", 'MR', 'ṆS'],
    avrohNote: 'Komal n comes down, and the phrase ends on the lower Ṇ.',
    mukhAng: ['ṆSR', 'MR', 'PMR', 'ṆS'],
    mukhAngNote: 'The phrases keep returning to R.',
    noteForms: _forms({'G': [], 'D': [], 'N': ['N', 'n']}),
    varjitAroh: ['G', 'D'],
    varjitAvroh: ['G', 'D'],
    story: [
      "What if I told you that you could take away two entire notes and still create a Raag with a completely recognizable identity? That's basically what we see with Raag Sarang.",
      "Sarang is a simple, lucid and tuneful melody that has been sung since ages. It is the 26th Raag in Sri Guru Granth Sahib Ji, beginning on Ang 1197 and continuing to Ang 1254. It comes from the Kafi Thaat, has an Audav-Audav Jaati, and is traditionally sung in the third quarter of the day, around midday.",
      "Audav-Audav means there are only five notes in the Aroh and five in the Avroh. So what's missing? G and D. They are Varjit in Sarang. All the notes are Shudh, except N, which is used in both forms: N going up and Komal n coming down.",
      "The Vaadee is R and the Samvaadee is P.",
      "Notice how the Mukh Ang phrases keep returning to R, rather than simply moving straight up and down the scale. These characteristic movements are what give Sarang its recognizable sound, even with only five notes. That is why Mukh Ang matters: five notes alone do not define a Raag. The movement of those notes does.",
      "Sarang is associated with feelings of spiritual fulfillment, and historically the Gurus used it to provide a \"cooling effect\" for the mind.",
    ],
    listenFor: [
      "Only five notes: there is no G and no D.",
      "Listen for the phrases coming back to R again and again.",
      "Listen for the Shudh N going up and the Komal n coming down.",
    ],
    quotes: [
      RaagQuote(
        gurmukhi:
            'ਫੀਕੇ ਹਰਿ ਕੇ ਨਾਮ ਬਿਨੁ ਸਾਦ॥\nਅੰਮ੍ਰਿ ਤਰਸੁ ਕੀਰਤਨੁ ਹਰਿ ਗਾਈਐ ਅਹਿਨਿਸਿ ਪੂਰਨ ਨਾਦ॥੧॥ਰਹਾਉ॥',
        meaning:
            "Without the Lord's Name, all other pleasures lose their sweetness. Sing the sweet praises of Waheguru through Kirtan, so that the divine Naad may resonate within you day and night. This reminds us that lasting fulfillment comes through connecting with Waheguru, and highlights Kirtan as a way of deepening that connection.",
        source: 'Sri Guru Granth Sahib Ji',
      ),
    ],
    exampleShabad: 'Sarang Mahalaa 5, Ang 1203: "Ab moro naachano raho"',
    didYouKnow: [
      "Sarang is a good reminder that more notes don't necessarily make a Raag more expressive. Sometimes, what you leave out is just as important as what you put in.",
    ],
    remember: [
      'Varjit notes: G and D',
      'Both forms of N are used',
      'The movement of the notes (Mukh Ang), not just the five notes, gives Sarang its identity',
    ],
  ),

  // ---------------------------------------------------------------- GOND
  'raag-8': RaagLessonContent(
    name: 'Raag Gond',
    tagline: 'Victory with humility, and a longing for the Guru',
    icon: Icons.favorite_border,
    audioKey: 'gond',
    raagNumber: '17th Raag',
    ang: 'Ang 859',
    thaat: 'Bilaval',
    jaati: 'Sampooran-Sampooran',
    jaatiMeaning: '7 notes going up, 7 coming down',
    time: 'Second quarter of the day',
    mood: 'Enthusiasm and longing',
    vaadee: 'S',
    vaadeeName: 'Shadaj',
    samvaadee: 'M',
    samvaadeeName: 'Madhyam',
    aroh: ['SRGM', "PDNDNS'"],
    arohNote: 'D and N move up and down: D N D N.',
    avroh: ["S'NDNP", 'MG', 'RS'],
    avrohNote: 'N D N P on the way back down.',
    mukhAng: ['RGM', 'PM', 'MPNDNP', 'DMGM', 'GRS'],
    mukhAngNote: 'Gond is an exclusive Raag of traditional Sikh Keertankaars.',
    noteForms: _forms(),
    story: [
      "Raag Gond is interesting because at first it might seem pretty similar to Bilaval. It comes from the same Thaat and uses all seven notes in their Shudh forms. But once you look at how the notes actually move, they start sounding very different.",
      "Gond is the 17th Raag in Sri Guru Granth Sahib Ji, beginning on Ang 859. It has a Sampooran-Sampooran Jaati and is traditionally sung during the second quarter of the day. It is an exclusive Raag of traditional Sikh Keertankaars.",
      "Gond is known for a feeling of enthusiasm and victory, balanced with humility, in the sense that we are longing for our Guru.",
      "Here is what to listen for: D and N don't just move straight up and down. You can hear D N D N in the Aroh and N D N P coming back down. That characteristic movement is what helps distinguish Gond from Bilaval. It is a good example of why two Raags can use the same notes but still sound completely different.",
      "The Vaadee is S and the Samvaadee is M. The remaining notes act as the Anuvaadee notes, and there are no Varjit notes, since all seven notes are used.",
    ],
    listenFor: [
      "Listen for D N D N going up and N D N P coming back down.",
      "Compare it with Bilaval: same notes, very different movement.",
    ],
    quotes: [
      RaagQuote(
        gurmukhi: 'ਹਰਿ ਤਿਸ ਕੀ ਆਸ ਕੀਜੈ ਮਨ ਮੇਰੇ',
        meaning:
            "O my mind, place your hope in the Lord. The Raag's combination of energy and longing helps bring out that feeling of hope in the Shabad.",
        source: 'Guru Ram Das Ji',
      ),
    ],
    exampleShabad: 'Gond, Bhagat Namdev Ji, Ang 873: "Mo kao taar le raamaa taar le"',
    didYouKnow: [
      "Gond isn't commonly heard today outside of Gurmat Sangeet, but it has an important place in Sri Guru Granth Sahib Ji.",
      "Shabads in Gond were composed by Guru Ram Das Ji, Guru Arjan Dev Ji, Bhagat Kabir Ji, Bhagat Namdev Ji and Bhagat Ravidas Ji.",
    ],
    remember: [
      'Same Thaat as Bilaval, but the notes move differently',
      'Characteristic movement: D N D N going up, N D N P coming down',
      'Feeling: enthusiasm and longing',
    ],
  ),

  // ---------------------------------------------------------------- MALHAR
  'raag-9': RaagLessonContent(
    name: 'Raag Malhar',
    tagline: 'The Raag of the rain',
    icon: Icons.water_drop,
    audioKey: 'malhar',
    raagNumber: '27th Raag',
    ang: 'Ang 1254 to 1294',
    thaat: 'Khamaj',
    jaati: 'Sampooran-Sampooran',
    jaatiMeaning: '7 notes going up, 7 coming down',
    time: 'Third quarter of the night',
    season: 'The rainy season and the month of Sawan',
    mood: 'Refreshing and calming',
    vaadee: 'M',
    vaadeeName: 'Madhyam',
    samvaadee: 'S',
    samvaadeeName: 'Shadaj',
    aroh: ['S', 'RGM', 'MRP', "nDNS'"],
    arohNote: 'Listen for M R P, then n D N S.',
    avroh: ["S'", 'DnPM', 'GMR', 'S'],
    avrohNote: 'Komal n appears on the way down too.',
    mukhAng: ['SRGM', 'MRP', 'DnPM', 'RS'],
    mukhAngNote: 'These characteristic movements help us recognize Malhar.',
    noteForms: _forms({'N': ['N', 'n']}),
    story: [
      "If there's one Raag that's almost impossible to separate from its season, it's Malhar and the rain. The Malhar family has been connected with the monsoon season for centuries, and that connection carries into Gurmat Sangeet as well. In fact, there is an entire Malhar family of Raags.",
      "Malhar is a time-honoured melody sung during the rainy season and the month of Sawan. It is the 27th Raag in Sri Guru Granth Sahib Ji, beginning on Ang 1254 and continuing to Ang 1294. It belongs to the Khamaj Thaat, is Sampooran-Sampooran, and is traditionally sung in the third quarter of the night.",
      "One thing that makes Malhar interesting is that both forms of N are used: Shudh N and Komal n. The Vaadee is M and the Samvaadee is S.",
      "Listen to this movement: M R P, and then n D N S'. Rather than simply moving straight up the scale, Malhar has recognizable movements like these that give it its identity. These characteristic movements are what help us recognize Malhar, rather than just looking at the notes it uses.",
      "Overall, Malhar has a refreshing and calming feeling, which connects really well with its association with rain and the monsoon season.",
    ],
    listenFor: [
      "Listen for the movement M R P.",
      "Then listen for n D N S': both forms of N appear.",
    ],
    quotes: [
      RaagQuote(
        gurmukhi: 'ਬਰਸੁ ਘਨਾ ਮੇਰਾ ਮਨੁ ਭੀਨਾ||',
        meaning:
            "The Shabad is saying that Waheguru is \"drenching\" our minds with love. The imagery of rain appears within Gurbani that is sung in the Raag associated with rain, which is really cool.",
        source: 'Guru Arjan Dev Ji',
      ),
    ],
    exampleShabad: 'Malhar Mahalaa 1, Ang 1254: "Karao binao gur apne preetam harvar aanh milaavai"',
    didYouKnow: [
      "Malhar was used by several Gurus and Bhagats, including Guru Nanak Dev Ji, Guru Angad Dev Ji, Guru Amar Das Ji, Guru Ram Das Ji, Guru Arjan Dev Ji, Bhagat Namdev Ji and Bhagat Ravidas Ji.",
    ],
    remember: [
      'Associated with the rainy season (the monsoon)',
      'Both forms of N are used',
      'Characteristic movement: M R P',
      'There is an entire Malhar family of Raags',
    ],
  ),

  // ---------------------------------------------------------------- SRI RAAG
  'raag-10': RaagLessonContent(
    name: 'Sri Raag',
    tagline: 'The first Raag: dignified and contemplative',
    icon: Icons.auto_awesome,
    audioKey: 'sri',
    raagNumber: '1st Raag',
    ang: 'Ang 14 to 94',
    thaat: 'Purvi',
    jaati: 'Audav-Sampooran',
    jaatiMeaning: '5 notes going up, 7 coming down',
    time: 'Dawn',
    mood: 'Serious and introspective, with dignity and contemplation',
    vaadee: 'r',
    vaadeeName: 'Komal Rishab',
    samvaadee: 'P',
    samvaadeeName: 'Pancham',
    aroh: ['Sr', 'mP', "NS'"],
    arohNote: 'Only five notes going up. G and D are Varjit.',
    avroh: ["S'NdP", 'mGr', 'S'],
    avrohNote: 'G and D both come back on the way down.',
    mukhAng: ['S', 'rr', 'P', 'PmGr', 'rr', 'S'],
    mukhAngNote:
        "In the book, tiny raised notes next to r are grace notes that ornament it. The smooth movement matters as much as the notes.",
    noteForms: _forms({'R': ['r'], 'M': ['m'], 'D': ['d']}),
    varjitAroh: ['G', 'D'],
    story: [
      "Did you know that Sri Raag is the first Raag we encounter in the Raag section of Sri Guru Granth Sahib Ji? It begins all the way on Ang 14 and continues to Ang 94, and it holds a prime place in the musical system of Sri Guru Granth Sahib Ji.",
      "It comes from the Purvi Thaat, has an Audav-Sampooran Jaati, and is traditionally sung at dawn. Its emotion is serious and introspective, with a feeling of dignity and contemplation.",
      "Going up, only five notes are used: G and D are Varjit in the Aroh. But both come back in the Avroh. In this Raag r and d are Komal, m is Teevar, and all the other notes are Shudh.",
      "The Vaadee is r (Komal R) and the Samvaadee is P.",
      "One of the most special things about Sri Raag is that it is considered meend-pradhaan. Meend is the smooth glide between notes, so you can't fully understand Sri Raag just by looking at its Aroh and Avroh. How you move between those notes is a huge part of the Raag itself. That is why meend is so important in Sri Raag: it creates smooth movement between the notes.",
      "This would be especially beautiful on a bowed Sikh heritage instrument like the Taus or Dilruba, because you can really sustain the notes and bring out the meend instead of playing each note separately.",
    ],
    listenFor: [
      "Listen for how smoothly the notes glide into each other (meend).",
      "Going up there is no G and no D. Coming down they return.",
    ],
    quotes: [
      RaagQuote(
        gurmukhi: 'ਰਾਗਾ ਵਿਚਿ ਸ੍ਰੀਰਾਗੁ ਹੈ',
        meaning: "Shree raag is above all. Gurbani itself emphasizes the significance of Sri Raag.",
        source: 'Sri Guru Granth Sahib Ji',
      ),
      RaagQuote(
        gurmukhi: 'ਰੰਗਿ ਰਤਾ ਮੇਰਾ ਸਾਹਿਬੁ ਰਵਿ ਰਹਿਆ ਭਰਪੂਰਿ ॥੧॥ ਰਹਾਉ ॥',
        meaning:
            "My Lord is immersed in love, and His presence fills everything. That message of being immersed in Waheguru's love fits the deep, contemplative character of Sri Raag really well.",
        source: 'Sri Raag',
      ),
    ],
    exampleShabad: 'Sri Raag Mahalaa 1, Ang 14: "Motee ta mandar oosareh ratnee ta hohi jarhaao"',
    remember: [
      'The first Raag in Sri Guru Granth Sahib Ji (Ang 14 to 94)',
      'G and D are Varjit in the Aroh',
      'Meend-pradhaan: it emphasizes smooth glides between notes',
      'Serious and introspective',
    ],
  ),

  // ---------------------------------------------------------------- MARU
  'raag-11': RaagLessonContent(
    name: 'Raag Maru',
    tagline: 'Strong, serious and intense',
    icon: Icons.bolt,
    audioKey: 'maru',
    raagNumber: '21st Raag',
    ang: 'Ang 989 to 1107',
    thaat: 'Khamaj',
    jaati: 'Shadav-Sampooran',
    jaatiMeaning: '6 notes going up, 7 coming down',
    time: 'Third quarter of the day',
    mood: 'Strength and seriousness',
    vaadee: 'G',
    vaadeeName: 'Gandhar',
    samvaadee: 'N',
    samvaadeeName: 'Nishad',
    aroh: ['SGMP', "DNS'"],
    arohNote: 'Six notes going up. R is Varjit.',
    avroh: ["S'nDP", 'mPdNdP', 'MGRS'],
    avrohNote: 'Much more detailed: both forms of M, D and N appear.',
    mukhAng: ['PPnDP', 'mPdNdP', 'PDPG', 'R', 'GRS'],
    mukhAngNote: 'Listen for the switches between Shudh and Komal or Teevar forms.',
    noteForms: _forms({
      'M': ['M', 'm'],
      'D': ['D', 'd'],
      'N': ['N', 'n'],
    }),
    varjitAroh: ['R'],
    story: [
      "You've officially made it to the final Raag! After joy, spring, peace and rain, Maaroo changes the energy completely. It has a much stronger and more intense character.",
      "Maaroo is a much valued Raag of Indian classical music, and it finds a significant place in Sri Guru Granth Sahib Ji. It is the 21st Raag, beginning on Ang 989 and continuing all the way to Ang 1107, which is around 118 Angs. It comes from the Khamaj Thaat, has a Shadav-Sampooran Jaati, and is traditionally sung in the third quarter of the day.",
      "Notice that R is Varjit in the Aroh, so only six notes are used while going up. But the Avroh is much more detailed.",
      "Here is where Maaroo gets really interesting: both forms of M, D and N can be used (M and m, D and d, N and n). Compared with something like Bilaval, its note structure is much more complex. A simple straight scale can't describe it. Its identity comes from complex movements and multiple forms of notes.",
      "The Vaadee is G and the Samvaadee is N. Maaroo is traditionally connected with a feeling of strength and seriousness.",
    ],
    listenFor: [
      "Going up it is simple: S G M P D N S'.",
      "Coming down, listen for the switches between M and m, D and d, N and n.",
    ],
    exampleShabad: 'Maaroo Mahalaa 9, Ang 1008: "Har ko naam sadaa sukhdaa-ee"',
    remember: [
      'R is Varjit in the Aroh',
      'Both forms of M, D and N are used',
      'Strong and serious character',
      'Its note structure is much more complex than a simple straight scale',
    ],
  ),
};
