import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:medicare/view/screens/auth/login/login_screen.dart';
import 'package:medicare/view_model/utils/app_colors.dart';
import 'package:medicare/view_model/utils/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.white,
      splashIconSize: 250,
      splash: Column(
        children: [
          Flexible(child: Image.asset(Images.logo, fit: BoxFit.cover)),
          const SizedBox(height: 10),
          AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                speed: const Duration(milliseconds: 50),
                'M E D I  C A R E',
                textStyle: TextStyle(
                  fontSize: 30,
                  color: AppColors.textSplash,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
      nextScreen:const LoginScreen(),
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
