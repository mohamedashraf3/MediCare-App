import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicare/view/components/customs/button_custom.dart';
import 'package:medicare/view/components/customs/textfeild_custom.dart';
import 'package:medicare/view/components/widgets/password_widget.dart';
import 'package:medicare/view_model/bloc/auth/auth_cubit.dart';
import 'package:medicare/view_model/utils/images.dart';
import '../../../../view_model/utils/app_colors.dart';
import '../../../components/customs/text_custom.dart';
import '../get_started_after_rest/get_started_screen_after_reset.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return Form(
                key: cubit.resetPasswordFormKey,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(45)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: ScreenUtil().setHeight(40),
                      ),
                      SvgPicture.asset(
                        Images.resetPassword,
                        height: 100.h,
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      TextCustom(
                        text: "Reset Password",
                        color: AppColors.lavender,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(60),
                      ),
                      PasswordWidget(cubit: cubit),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      CustomTextField(
                        labelName: "Confirm Password",
                        controller: cubit.confirmPasswordController,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: cubit.conPasswordVisible,
                        hintText: "Enter your password again",
                        validator: (value) {
                          if (value != cubit.passwordController.text) {
                            return "Password don't match";
                          } else if (value!.isEmpty) {
                            return "Password can't be empty";
                          } else if (value.length < 8) {
                            return "Password must be at least 8 characters";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        suffixIcon: IconButton(
                          icon: cubit.conPasswordVisible
                              ? const Icon(
                            Icons.visibility_off,
                            color: AppColors.darkGrey,
                            size: 25,
                          )
                              : const Icon(
                            Icons.remove_red_eye,
                            color: AppColors.darkGrey,
                            size: 25,
                          ),
                          onPressed: () {
                            cubit.changeConPasswordVisibility();
                          },
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(30),
                      ),
                      ButtonCustom(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(0),
                        ),
                        width: double.infinity,
                        onPressed: () {
                          if (cubit.resetPasswordFormKey.currentState!
                              .validate()) {
                            cubit.resetPasswordWithApi();
                            Navigator.pushAndRemoveUntil(
                                context, MaterialPageRoute(
                                builder: (context) => const GetStartedScreenAfterReset()), (
                                route) => false);
                          }
                        },
                        child: TextCustom(
                          text: "Reset Password",
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
