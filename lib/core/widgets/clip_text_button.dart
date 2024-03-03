import 'package:dementia/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ClipTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isActive;
  final String text;
  const ClipTextButton({
    super.key,
    required this.isActive,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryColor : null,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.amber),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isActive ? Colors.white : AppColors.primaryColor),
        ),
      ),
    );
  }
}
