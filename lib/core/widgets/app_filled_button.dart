import 'package:flutter/cupertino.dart';
// ignore: implementation_imports

class AppFilledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  const AppFilledButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: backgroundColor ?? const Color(0xFF4C6FFF),
      onPressed: onPressed,
      child: child,
    );
  }
}
