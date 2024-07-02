import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view/screens/auth/login/sections/third_party_authentication.dart';
import 'package:medicare/view_model/utils/app_colors.dart';

import 'sections/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30),vertical: ScreenUtil().setHeight(30)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(80),
                ),
                const TextCustom(
                  text: "Log In",
                  color: AppColors.lavender,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(15),
                ),
                const TextCustom(
                  text: "Welcome back !",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height:ScreenUtil().setHeight(50),
                ),
                const LoginForm(),
                SizedBox(height:ScreenUtil().setHeight(30),),
                const ThirdPartyAuthenticationLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
