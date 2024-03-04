part of "anime_detail_screen.dart";

class _SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const _SectionTitle({required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: s20W700(context).copyWith(color: AppColors.black)),
            if (onPressed != null)
              const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}

class _InformationElement extends StatelessWidget {
  final String title;
  final String text;
  const _InformationElement({
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: s14W500(context).copyWith(color: AppColors.black)),
          const SizedBox(height: 3),
          Opacity(
            opacity: 0.7,
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

class _GeneralInformations extends StatelessWidget {
  final SingleAnimeGeneralInfo animeGeneralInfo;
  const _GeneralInformations({required this.animeGeneralInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: 'General Information'),
        const SizedBox(height: 10),
        if (animeGeneralInfo.aired?.from != null)
          _InformationElement(
            title: 'Aired from:',
            text: DateFormat.yMMMd().format(animeGeneralInfo.aired!.from),
          ),
        const SizedBox(height: 10),
        if (animeGeneralInfo.rating != null)
          _InformationElement(
            title: 'Rating:',
            text: animeGeneralInfo.rating!,
          ),
        const SizedBox(height: 10),
        if (animeGeneralInfo.duration != null)
          _InformationElement(
              title: 'Duration:', text: animeGeneralInfo.duration!),
        const SizedBox(height: 10),
        if (animeGeneralInfo.episodes != null)
          _InformationElement(
            title: 'Episodes:',
            text: animeGeneralInfo.episodes.toString(),
          ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _RedirectButton extends StatelessWidget {
  final String title;
  final SvgIcons icon;
  final VoidCallback onPressed;
  const _RedirectButton({
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppFilledButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon.toIcon(),
            const SizedBox(width: 5),
            Text(title, style: s16W400(context)),
          ],
        ),
      ),
    );
  }
}
