import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicare/view_model/utils/app_colors.dart';

import '../../customs/button_custom.dart';
import '../../customs/text_custom.dart';

class SuccessScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final String message;
  final Widget goToScreen;
  final String? textButton;

  const SuccessScreen(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.message,
      required this.goToScreen,
      this.textButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: ScreenUtil().setHeight(110)),
              SvgPicture.asset(
                imagePath,
                height: 100.h,
              ),
              SizedBox(height: ScreenUtil().setHeight(50)),
              TextCustom(
                text: title,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: AppColors.lavender,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ScreenUtil().setHeight(25)),
              TextCustom(
                  text: message,
                  fontSize: 13.7,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center),
              Expanded(child: SizedBox(height: ScreenUtil().setHeight(60))),
              ButtonCustom(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                width: double.infinity,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => goToScreen),
                      (route) => false);
                },
                child: TextCustom(
                    text: textButton ?? "Get Started",
                    fontSize: 15.7,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white),
              ),
              SizedBox(
                height: 100.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
