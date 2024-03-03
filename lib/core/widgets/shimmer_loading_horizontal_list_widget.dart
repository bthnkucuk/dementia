import 'package:dementia/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// [ShimmerLoadingHorizontalListWidget] is a widget that displays a shimmer loading horizontal list.
class ShimmerLoadingHorizontalListWidget extends StatelessWidget {
  final double elementWidth;
  final double elementHeight;
  const ShimmerLoadingHorizontalListWidget(
      {super.key, required this.elementWidth, required this.elementHeight});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      separatorBuilder: (context, index) => const SizedBox(width: 16),
      itemBuilder: (BuildContext context, int index) {
        return Shimmer(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColors.grey,
              AppColors.grey.withOpacity(0.2),
              AppColors.grey,
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.grey,
                ),
                width: elementWidth,
                height: elementHeight,
              ),
            ],
          ),
        );
      },
    );
  }
}
