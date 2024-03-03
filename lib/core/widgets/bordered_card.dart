import 'package:dementia/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/app_cached_network_image.dart';

class BorderedCard extends StatelessWidget {
  final String? avatarUrl;
  final String? title;
  final String? textTitle;
  final String text;
  final int? textMaxLines;
  const BorderedCard({
    super.key,
    this.avatarUrl,
    this.title,
    this.textTitle,
    required this.text,
    this.textMaxLines = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.grey),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AppCachedNetworkImage(
                  imageUrl: avatarUrl,
                  width: 20,
                  height: 20,
                ),
              ),
              const SizedBox(width: 8),
              if (title != null)
                Text(
                  title!,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
            ],
          ),
          const SizedBox(height: 10),
          if (textTitle != null)
            Text(textTitle ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
          if (textTitle != null) const SizedBox(height: 2),
          Text(text,
              maxLines: textMaxLines,
              overflow: textMaxLines != null ? TextOverflow.ellipsis : null,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  )),
        ],
      ),
    );
  }
}
