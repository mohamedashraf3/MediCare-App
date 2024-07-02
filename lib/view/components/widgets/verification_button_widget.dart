import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_model/bloc/auth/auth_cubit.dart';
import '../../../view_model/utils/app_colors.dart';
import '../customs/button_custom.dart';
import '../customs/text_custom.dart';
class VerificationButton extends StatelessWidget {
  const VerificationButton({super.key, required this.cubit, required this.child, required this.onPressedAfterCheck});
  final AuthCubit cubit;
  final Widget child;
  final VoidCallback onPressedAfterCheck;

  @override
  Widget build(BuildContext context) {
    return ButtonCustom(
      color: cubit.otpController.text.length == 4
          ? AppColors.lavender
          : AppColors.lavender.withOpacity(0.5),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(40),
      ),
      width: MediaQuery.of(context).size.width,
      onPressed: cubit.otpController.text.length != 4
          ? null
          : onPressedAfterCheck,
      child: TextCustom(
          text: 'Verify',
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold),
    );
  }
}
