// ignore_for_file: constant_identifier_names

enum AnimeType {
  TV,
  MOVIE,
  OVA,
  SPECIAL,
  ONA,
  MUSIC,
  CM,
  PV,
  TV_SPECIAL;

  static AnimeType? fromString(String? type) {
    switch (type) {
      case 'tv':
        return AnimeType.TV;
      case 'movie':
        return AnimeType.MOVIE;
      case 'ova':
        return AnimeType.OVA;
      case 'special':
        return AnimeType.SPECIAL;
      case 'ona':
        return AnimeType.ONA;
      case 'music':
        return AnimeType.MUSIC;
      case 'cm':
        return AnimeType.CM;
      case 'pv':
        return AnimeType.PV;
      case 'tv_special':
        return AnimeType.TV_SPECIAL;
      default:
        return null;
    }
  }

  String get titleString {
    switch (this) {
      case AnimeType.TV:
        return 'TV';
      case AnimeType.MOVIE:
        return 'Movie';
      case AnimeType.OVA:
        return 'OVA';
      case AnimeType.SPECIAL:
        return 'Special';
      case AnimeType.ONA:
        return 'ONA';
      case AnimeType.MUSIC:
        return 'Music';
      case AnimeType.CM:
        return 'CM';
      case AnimeType.PV:
        return 'PV';
      case AnimeType.TV_SPECIAL:
        return 'TV Special';
    }
  }

  String get underScoreString {
    switch (this) {
      case AnimeType.TV:
        return 'tv';
      case AnimeType.MOVIE:
        return 'movie';
      case AnimeType.OVA:
        return 'ova';
      case AnimeType.SPECIAL:
        return 'special';
      case AnimeType.ONA:
        return 'ona';
      case AnimeType.MUSIC:
        return 'music';
      case AnimeType.CM:
        return 'cm';
      case AnimeType.PV:
        return 'pv';
      case AnimeType.TV_SPECIAL:
        return 'tv_special';
    }
  }
}
