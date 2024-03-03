enum HeroTagType {
  animeImage,
  animeTitle,
  synopsis;

  String toHeroTag(int malId) {
    switch (this) {
      case HeroTagType.animeImage:
        return 'ANIME_IMAGE_HERO_TAG_$malId';
      case HeroTagType.animeTitle:
        return 'ANIME_TITLE_HERO_TAG_$malId';
      case HeroTagType.synopsis:
        return 'ANIME_SYNOPSIS_HERO_TAG_$malId';
    }
  }
}
