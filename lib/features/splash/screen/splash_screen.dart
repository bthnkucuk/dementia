import 'package:dementia/anime_app.dart';
import 'package:dementia/config/router/anime_route.dart';
import 'package:dementia/config/theme/app_colors.dart';
import 'package:dementia/config/theme/text_styles.dart';
import 'package:dementia/core/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 2), () => HomeRoute().go(context));

      return null;
    }, []);
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageConstants.appLogo,
                width: MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                appFlavor?.name ?? 'Dementia',
                style: s18W700.copyWith(color: AppColors.black),
              )
            ],
          ),
        ));
  }
}
