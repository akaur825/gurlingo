
class LessonAudioService {
  static String _prefix(String scale) {
    return scale == 'G#' ? 'G#' : 'C#';
  }

  // Raag Aroh recordings.
  static String raagAroh(String scale, String raag) {
    return 'assets/audio/${_prefix(scale)}_${_raagFileKey(raag)}_aroh.mp3';
  }

  // Raag Avroh recordings.
  static String raagAvroh(String scale, String raag) {
    return 'assets/audio/${_prefix(scale)}_${_raagFileKey(raag)}_avroh.mp3';
  }

  static String _raagFileKey(String raag) {
    const keys = {
      'Bilaval': 'bilaval',
      'Basant': 'basant',
      'Kalyan': 'kalyan',
      'Bhairo': 'bhairo',
      'Todi': 'todi',
      'Sarang': 'sarang',
      'Gond': 'gond',
      'Malhar': 'malhar',
      'Sri': 'sri',
      'Maru': 'maru',
    };

    final key = keys[raag];

    if (key == null) {
      throw ArgumentError('No audio filename mapping found for raag: $raag');
    }

    return key;
  }

  // Individual Sur recordings.
  static String surAudio(String scale, String sur) {
    final prefix = _prefix(scale);

    const files = {
      'S': '_S.mp3',
      'R': '_R.mp3',
      'G': '_G.mp3',
      'M': '_M.mp3',
      'P': '_P.mp3',
      'D': '_D.mp3',
      'N': '_N.mp3',
      'r': '_r_komal.mp3',
      'g': '_g_komal.mp3',
      'm': '_m_teevar.mp3',
      'd': '_d_komal.mp3',
      'n': '_n_komal.mp3',
    };

    final filename = files[sur];

    if (filename == null) {
      throw ArgumentError('No audio filename mapping found for Sur: $sur');
    }

    return 'assets/audio/$prefix$filename';
  }

  // Sargam practice recordings.
  // Keys are the exact written practice sequences.
  static String sargamAudio(String scale, String sequence) {
    final prefix = _prefix(scale);

    // A single note uses its individual Sur recording.
    if (sequence.length == 1) {
      return surAudio(scale, sequence);
    }

    const files = {
      // Shudh Re
      'RRSS': '_RRSS.mp3',
      'SRRRS': '_SRRRS.mp3',
      'SRSRSR': '_SRSRSR.mp3',
      'SSRSRR': '_SSRSRR.mp3',
      'RSRRRSRR': '_RSRRRSRR.mp3',
      'RSSRSS': '_RSSRSS.mp3',

      // Shudh Ga
      'GGRS': '_GGRS.mp3',
      'RGSRG': '_RGSRG.mp3',
      'GSSRGGG': '_GSSRGGG.mp3',
      'SGGRSRR': '_SGGRSRR.mp3',
      'RSRGRRSG': '_RSRGRRSG.mp3',
      'SRGRGSGSRG': '_SRGRGSGSRG.mp3',

      // Shudh Ma
      'MMGGRRSS': '_MMGGRRSS.mp3',
      'SRMGSRGS': '_SRMGSRGS.mp3',
      'RMMMGGR': '_RMMMGGR.mp3',
      'GSRMRS': '_GSRMRS.mp3',
      'MSRGRS': '_MSRGRS.mp3',
      'RGMGMRMRGM': '_RGMGMRMRGM.mp3',

      // Shudh Pa
      'SRGMP': '_SRGMP.mp3',
      'GPMGR': '_GPMGR.mp3',
      'SGPGPS': '_SGPGPS.mp3',
      'MPGSRMP': '_MPGSRMP.mp3',
      'RMPMRS': '_RMPMRS.mp3',
      'GMPMPGPGMP': '_GMPMPGPGMP.mp3',

      // Shudh Dha
      'GMPDDP': '_GMPDDP.mp3',
      'RMPDS’DP': '_RMPDSDP.mp3',
      'MGRSGPD': '_MGRSGPD.mp3',
      'DDPDMRGMP': '_DDPDMRGMP.mp3',
      'SMGPMDP': '_SMGPMDP.mp3',
      'MPDPDMDMPD': '_MPDPDMDMPD.mp3',

      // Shudh Ni
      'NS’DPMRS': '_NSDPMRS.mp3',
      'SRMPNDS’': '_SRMPNDS.mp3',
      'NNNS’DDPP': '_NNNSDDPP.mp3',
      'GMPDNDNDP': '_GMPDNDNDP.mp3',
      'MDNNNDGMG': '_MDNNNDGMG.mp3',
      'PDNDNPNPDN': '_PDNDNPNPDN.mp3',

      // Komal Re
      'SrGrrS': '_SrGrrS.mp3',
      'SRGMrrSrr': '_SRGMrrSrr.mp3',
      'rPPMGr': '_rPPMGr.mp3',
      'RSGPGr': '_RSGPGr.mp3',
      'DPGrS': '_DPGrS.mp3',
      'rGMGMrMrGM': '_rGMGMrMrGM_komal.mp3',

      // Komal Ga
      'ggrgrS': '_ggrgrS.mp3',
      'gMPMgRS': '_gMPMgRS.mp3',
      'PgMRS’': '_PgMRS.mp3',
      'PGrSggMP': '_PGrSggMP.mp3',
      'gMDPMgRS': '_gMDPMgRS.mp3',
      'SRgRgSgSRg': '_SRgRgSgSRg_komal.mp3',

      // Teevar Ma
      'SRmmPDP': '_SRmmPDP.mp3',
      'mGPmGrS': '_mGPmGrS.mp3',
      'GmPmGrS': '_GmPmGrS_teevar.mp3',
      'MGPmDPP': '_MGPmDPP.mp3',
      'mmmDNNNDNP': '_mmmDNNNDNP.mp3',
      'GmPmPGPGmP': '_GmPmPGPGmP_teevar.mp3',

      // Komal Dha
      'rgrPmdP': '_rgrPmdP.mp3',
      'ddPdddMPGM': '_ddPdddMPGM.mp3',
      'mdNS’Nr’S’': '_mdNSNrS.mp3',
      'gmdNdmgrS': '_gmdNdmgrS.mp3',
      'RMPdNdP': '_RMPdNdP.mp3',
      'MPdPdMdMPD': '_MPdPdMdMPD_komal.mp3',

      // Komal Ni
      'NS’NS’DnDn': '_NSNSDnDn.mp3',
      'nDNS’DnP': '_nDNSDnP.mp3',
      'GMDnnDPP': '_GMDnnDPP.mp3',
      'RMPnnPnnnPMP': '_RMPnnPnnnPMP.mp3',
      'DGMPnDP': '_DGMPnDP.mp3',
      'PDnDnPnPDn': '_PDnDnPnPDn_komal.mp3',
    };

    final filename = files[sequence];

    if (filename == null) {
      throw ArgumentError(
        'No audio filename mapping found for sequence: $sequence',
      );
    }

    return 'assets/audio/$prefix$filename';
  }
}
