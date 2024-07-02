import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/button_custom.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view_model/data/local/shared_prefrence/shared_prefrence.dart';
import 'package:medicare/view_model/utils/app_colors.dart';

import '../../../model/content_model.dart';
import '../../../view_model/data/local/shared_prefrence/shared_keys.dart';
import '../../../view_model/utils/routes.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController controller;

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              LocalData.set(key: SharedKeys.isFirstTime, value: false);
              Navigator.pushNamedAndRemoveUntil(
                  context, NamedRoutes.login, (route) => false);
            },
            child: TextCustom(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                  vertical: ScreenUtil().setHeight(3)),
              text: "Skip",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: ScreenUtil().setHeight(40)),
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(35)),
                  child: Column(
                    children: [
                      Image.asset(
                        contents[i].image,
                        height: 250.h,
                      ),
                      TextCustom(
                        text: contents[i].title,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.lavender,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      TextCustom(
                        text: contents[i].discription,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Container(
              height: 60,
              margin: EdgeInsets.all(40),
              width: double.infinity,
              child: ButtonCustom(
                onPressed: () {
                  if (currentIndex == contents.length - 1) {
                    LocalData.set(key: SharedKeys.isFirstTime, value: false);
                    Navigator.pushReplacementNamed(context, NamedRoutes.login);
                  }
                  controller.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceIn,
                  );
                },
                child: TextCustom(
                  text: currentIndex == contents.length - 1
                      ? "Get Started"
                      : "Next",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ))
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 8,
      width: currentIndex == index ? 32 : 16,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? AppColors.lavender : AppColors.grey,
      ),
    );
  }
}
