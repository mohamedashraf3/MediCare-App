import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicare/view/components/customs/button_custom.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view/components/customs/textfeild_custom.dart';
import 'package:medicare/view/components/widgets/phone_widget.dart';
import 'package:medicare/view/screens/auth/reset_password/reset_password_screen.dart';
import 'package:medicare/view/screens/auth/verification/verification_screen.dart';
import 'package:medicare/view_model/bloc/auth/auth_cubit.dart';
import 'package:medicare/view_model/utils/app_colors.dart';
import 'package:medicare/view_model/utils/images.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
      ),
      body: Form(
        key: cubit.forgotPasswordFormKey,
        child: SingleChildScrollView(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Images.forgetPassword,
                    height: 140.h,
                  ),
                  TextCustom(
                    text: "Forget Password !",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lavender,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  TextCustom(
                    text: cubit.usingEmail
                        ? "Don’t worry! It happens. Please enter the email associated with your account."
                        : "Don’t worry! It happens. Please enter your phone number",
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkGrey,
                    textAlign: TextAlign.center,
                    fontSize: 14,
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(40)),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(50),
                  ),
                  cubit.usingEmail
                      ? CustomTextField(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(40)),
                          labelName: "Email",
                          hintText: "example@gmail.com",
                          controller: cubit.emailController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.emailAddress,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email can't be empty";
                            } else if (!(value.contains("@") &&
                                value.contains("."))) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(40)),
                          child: PhoneWidget(cubit: cubit),
                        ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  ButtonCustom(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(40)),
                    width: double.infinity,
                    onPressed: () {
                      if (cubit.forgotPasswordFormKey.currentState!
                          .validate()) {
                        cubit.forgotPasswordFormKey.currentState!.validate();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  VerificationScreen(
                                      nameScreen: ResetPasswordScreen(), verify: () {
                                        return cubit.forgetPasswordWithApi();
                                },)));
                      }
                    },
                    child: const TextCustom(
                      text: "Send code",
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(40),
                  ),
                  InkWell(
                    onTap: () {
                      cubit.restController();
                      cubit.changeForgotPasswordMethod();
                    },
                    child: TextCustom(
                      text: cubit.usingEmail
                          ? "Use Phone Number"
                          : "Use Email Address",
                      fontSize: 16,
                      color: AppColors.lavender,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
