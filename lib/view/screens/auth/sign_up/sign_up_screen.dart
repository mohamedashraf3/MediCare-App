import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view/screens/auth/sign_up/sections/sign_up_form.dart';
import 'package:medicare/view/screens/auth/sign_up/sections/third_party_authentication.dart';
import 'package:medicare/view_model/utils/app_colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(30),
              vertical: ScreenUtil().setHeight(0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              TextCustom(
                text: "Sign Up",
                color: AppColors.lavender,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              SignUpForm(),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              ThirdPartyAuthenticationSingUp(),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
