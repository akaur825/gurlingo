
import '../services/lesson_audio_service.dart';

class SurPracticeItem {
  final String sequence;
  final String audioPath;

  const SurPracticeItem({
    required this.sequence,
    required this.audioPath,
  });
}

class SurLessonContent {
  final String id;
  final String title;
  final String surName;
  final String writtenContent;
  final List<String> practiceSequences;

  const SurLessonContent({
    required this.id,
    required this.title,
    required this.surName,
    required this.writtenContent,
    required this.practiceSequences,
  });

  // Creates the audio practice items for the selected scale.
  List<SurPracticeItem> practiceItems(String scale) {
    return practiceSequences.map((sequence) {
      return SurPracticeItem(
        sequence: sequence,
        audioPath: LessonAudioService.sargamAudio(scale, sequence),
      );
    }).toList();
  }
}

class SurLessonData {
  static const String greeting =
      'Waheguru Ji Ka Khalsa, Waheguru Ji Ki Fateh.';

  static const String singingInstructions =
      'Listen to each practice Sargam recording and try to sing along '
      'to familiarize yourself with the Sur. If the scale is not in your '
      'vocal range, note the Sargams, turn on an electronic tanpura to '
      'your scale, and practice singing on your own scale.';

  static final List<SurLessonContent> lessons = [
    // 1. Introduction to Sur + Sa
    const SurLessonContent(
      id: 'sur-1',
      title: 'Introduction to Sur + Sa - Shadaj',
      surName: 'Sa - Shadaj',
      writtenContent: '''
$greeting

Before we start learning individual Surs, we need to understand some of the basic terms and concepts we'll be using throughout this course.

Let's start with the most important question: what exactly is a Sur?

A Sur is a musical note — a specific pitch that we hear and produce when singing or playing an instrument.

In Gurmat Sangeet, we primarily use the Sargam system to name our Surs:

Sa, Re, Ga, Ma, Pa, Dha, Ni.

These seven Surs make up the basic Saptak, or octave.

You may have heard of other systems for naming musical notes, such as Do, Re, Mi, Fa, Sol, La, Ti. But in this course, we'll be using the traditional Sargam names: Sa, Re, Ga, Ma, Pa, Dha, and Ni.

Now, it's important to understand that there aren't only seven possible pitches. There are twelve Surs within an octave, including both Shudh and Vakrit Surs. So let's talk about what makes these Surs different.

The seven basic Surs are called Shudh Surs. Shudh means pure or natural. The Shudh Surs are: Sa, Re, Ga, Ma, Pa, Dha, Ni.

A Vakrit Sur is a variation of a Shudh Sur. There are two types of Vakrit Surs: Komal and Teevar. However, we will focus more on these notes in the next section, Vakrit Surs.

An important thing to note is that not every Shudh Sur has a Vakrit form. Those Surs are known as Achala Surs, meaning they remain fixed. The two Achala Surs are Sa and Pa.

The first Sur we will focus on is Sa, whose full name is Shadaj. Before continuing to the quiz, practice singing Sa with a tanpura.

$greeting
''',
      practiceSequences: ['S'],
    ),

    // 2. Re - Rishab
    const SurLessonContent(
      id: 'sur-2',
      title: 'Re - Rishab',
      surName: 'Re - Rishab',
      writtenContent: '''
$greeting

The next Shudh Sur is Re, whose full name is Rishab.

$singingInstructions

$greeting
''',
      practiceSequences: [
        'R',
        'RRSS',
        'SRRRS',
        'SRSRSR',
        'SSRSRR',
        'RSRRRSRR',
        'RSSRSS',
      ],
    ),

    // 3. Ga - Gandhar
    const SurLessonContent(
      id: 'sur-3',
      title: 'Ga - Gandhar',
      surName: 'Ga - Gandhar',
      writtenContent: '''
$greeting

The next Shudh Sur is Ga, whose full name is Gandhar.

$singingInstructions

$greeting
''',
      practiceSequences: [
        'G',
        'GGRS',
        'RGSRG',
        'GSSRGGG',
        'SGGRSRR',
        'RSRGRRSG',
        'SRGRGSGSRG',
      ],
    ),

    // 4. Ma - Madhyam
    const SurLessonContent(
      id: 'sur-4',
      title: 'Ma - Madhyam',
      surName: 'Ma - Madhyam',
      writtenContent: '''
$greeting

The next Shudh Sur is Ma, whose full name is Madhyam.

$singingInstructions

$greeting
''',
      practiceSequences: [
        'M',
        'MMGGRRSS',
        'SRMGSRGS',
        'RMMMGGR',
        'GSRMRS',
        'MSRGRS',
        'RGMGMRMRGM',
      ],
    ),

    // 5. Pa - Pancham
    const SurLessonContent(
      id: 'sur-5',
      title: 'Pa - Pancham',
      surName: 'Pa - Pancham',
      writtenContent: '''
$greeting

The next Shudh Sur is Pa, whose full name is Pancham.

$singingInstructions

$greeting
''',
      practiceSequences: [
        'P',
        'SRGMP',
        'GPMGR',
        'SGPGPS',
        'MPGSRMP',
        'RMPMRS',
        'GMPMPGPGMP',
      ],
    ),

    // 6. Dha - Dhaiwat
    const SurLessonContent(
      id: 'sur-6',
      title: 'Dha - Dhaiwat',
      surName: 'Dha - Dhaiwat',
      writtenContent: '''
$greeting

The next Shudh Sur is Dha, whose full name is Dhaiwat.

$singingInstructions

$greeting
''',
      practiceSequences: [
        'D',
        'GMPDDP',
        'RMPDS’DP',
        'MGRSGPD',
        'DDPDMRGMP',
        'SMGPMDP',
        'MPDPDMDMPD',
      ],
    ),

    // 7. Ni - Nishad
    const SurLessonContent(
      id: 'sur-7',
      title: 'Ni - Nishad',
      surName: 'Ni - Nishad',
      writtenContent: '''
$greeting

The next Shudh Sur is Ni, whose full name is Nishad.

$singingInstructions

$greeting
''',
      practiceSequences: [
        'N',
        'NS’DPMRS',
        'SRMPNDS’',
        'NNNS’DDPP',
        'GMPDNDNDP',
        'MDNNNDGMG',
        'PDNDNPNPDN',
      ],
    ),

    // 8. Introduction to Vakrit Sur + Komal Re
    const SurLessonContent(
      id: 'vakrit-1',
      title: 'Introduction to Vakrit Sur + Komal Re',
      surName: 'Komal Re',
      writtenContent: '''
$greeting

Now that we've learned all seven Shudh Surs, we're ready to learn another important part of the Sur system: Vakrit Surs. Vakrit Surs are notated in lowercase letters. As we learned in the Introduction to Sur, a Vakrit Sur is a variation of a Shudh Sur. There are two types of Vakrit Surs that we'll be learning: Komal and Teevar.

A Komal Sur is a lower, or flatter variation of a Shudh Sur. There are four Komal Surs:

Komal Re, Komal Ga, Komal Dha, and Komal Ni.

A Teevar Sur is a higher, or sharper variation of a Shudh Sur. There is one Teevar Sur:

Teevar Ma.

It's important to remember that Sa and Pa do not have Vakrit forms. These are our two Achala Surs.

So if we put everything together, we have our seven Shudh Surs:

Sa, Re, Ga, Ma, Pa, Dha, Ni

And the Vakrit variations:

Komal Re, Komal Ga, Teevar Ma, Komal Dha, Komal Ni.

Which make up the twelve notes in a Saptak, or Octave.

We’ll start with Komal Re.

$singingInstructions

$greeting
''',
      practiceSequences: [
        'r',
        'SrGrrS',
        'SRGMrrSrr',
        'rPPMGr',
        'RSGPGr',
        'DPGrS',
        'rGMGMrMrGM',
      ],
    ),

    // 9. Komal Ga
    const SurLessonContent(
      id: 'vakrit-2',
      title: 'Komal Ga',
      surName: 'Komal Ga',
      writtenContent: '''
$greeting

The next Vakrit Sur is Komal Ga.

$singingInstructions

$greeting
''',
      practiceSequences: [
        'g',
        'ggrgrS',
        'gMPMgRS',
        'PgMRS',
        'PGrSggMP',
        'gMDPMgRS',
        'SRgRgSgSRg',
      ],
    ),

    // 10. Teevar Ma
    const SurLessonContent(
      id: 'vakrit-3',
      title: 'Teevar Ma',
      surName: 'Teevar Ma',
      writtenContent: '''
$greeting

The next Vakrit Sur is Teevar Ma.

$singingInstructions

$greeting
''',
      practiceSequences: [
        'm',
        'SRmmPDP',
        'mGPmGrS',
        'GmPmGrS',
        'MGPmDPP',
        'mmmDNNNDNP',
        'GmPmPGPGmP',
      ],
    ),

    // 11. Komal Dha
    const SurLessonContent(
      id: 'vakrit-4',
      title: 'Komal Dha',
      surName: 'Komal Dha',
      writtenContent: '''
$greeting

The next Vakrit Sur is Komal Dha.

$singingInstructions

$greeting
''',
      practiceSequences: [
        'd',
        'rgrPmdP',
        'ddPdddMPGM',
        'mdNS’Nr’S’',
        'gmdNdmgrS',
        'RMPdNdP',
        'MPdPdMdMPd',
      ],
    ),

    // 12. Komal Ni
    const SurLessonContent(
      id: 'vakrit-5',
      title: 'Komal Ni',
      surName: 'Komal Ni',
      writtenContent: '''
$greeting

The next Vakrit Sur is Komal Ni.

$singingInstructions

$greeting
''',
      practiceSequences: [
        'n',
        'NS’NS’DnDn',
        'nDNS’DnP',
        'GMDnnDPP',
        'RMPnnPnnnPMP',
        'DGMPnDP',
        'PDnDnPnPDn',
      ],
    ),
  ];

  static SurLessonContent? getLesson(String id) {
    for (final lesson in lessons) {
      if (lesson.id == id) {
        return lesson;
      }
    }

    return null;
  }
}
