import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view/components/widgets/verification_button_widget.dart';
import 'package:medicare/view_model/bloc/auth/auth_cubit.dart';
import 'package:medicare/view_model/utils/app_colors.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key, required this.nameScreen, required this.verify});

  final Widget nameScreen ;
  final Future<void> Function() verify;

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
      body: SingleChildScrollView(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: ScreenUtil().setHeight(60)),
                TextCustom(
                  text: cubit.usingEmail
                      ? 'Check your email !'
                      : 'Check your inbox!',
                  fontSize: 24,
                  color: AppColors.lavender,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(25),
                ),
                Center(
                  child: TextCustom(
                    text: cubit.usingEmail
                        ? 'We’ve sent a code to ${cubit.emailController.text}'
                        : 'We’ve sent a code to ${cubit.countryController.text}${cubit.mobilePhoneController.text}',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(55),
                ),
                Pinput(
                  length: 4,
                  controller: cubit.otpController,
                  onChanged: (value) {
                    cubit.checkOtpLength(value);
                  },
                  onCompleted: (value) {
                    cubit.countryController.text = value;
                  },
                  autofocus: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Code can't be empty";
                    } else if (value.length != 4) {
                      return "Enter a valid code";
                    }
                    return null;
                  },
                  showCursor: true,
                  pinAnimationType: PinAnimationType.scale,
                  defaultPinTheme: PinTheme(
                    margin: const EdgeInsets.all(8),
                    width: 64,
                    height: 70,
                    textStyle: TextStyle(fontSize: 16.sp, color: Colors.black),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  errorPinTheme: PinTheme(
                    margin: const EdgeInsets.all(8),
                    width: 64,
                    height: 70,
                    textStyle: TextStyle(fontSize: 16.sp, color: Colors.red),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.red),
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                    FilteringTextInputFormatter.deny(' '),
                    FilteringTextInputFormatter.deny(RegExp(r"\s")),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(55),
                ),
                VerificationButton(cubit: cubit,child:nameScreen,onPressedAfterCheck:(){
                  verify().then((value) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => nameScreen));
                  });
                },),
                SizedBox(
                  height: ScreenUtil().setHeight(40),
                ),
                cubit.isTimerActive
                    ? TextCustom(
                        text: "Send code again in 00:${cubit.remainingTime}",
                        color: AppColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)
                    : InkWell(
                        onTap: () {
                          cubit.resetTimer();
                          cubit.startTimer();
                        },
                        child: TextCustom(
                            text: "Send code again",
                            color: AppColors.lavender,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
