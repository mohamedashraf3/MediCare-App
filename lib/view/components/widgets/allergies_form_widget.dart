import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_model/bloc/health_follow-up/health_form_cubit.dart';
import '../../../view_model/utils/app_colors.dart';
import '../customs/textfeild_custom.dart';

class AllergiesFormWidget extends StatelessWidget {
  const AllergiesFormWidget({Key? key, required this.cubit, this.maxLines, this.labelText, this.hintText, this.padding, this.validator}) : super(key: key);
  final HealthFormCubit cubit;
  final int ? maxLines;
  final String? labelText;
  final String? hintText;
  final EdgeInsets? padding;
final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      autoValidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]')),
        LengthLimitingTextInputFormatter(100),
      ],
      floatingLabelBehavior: FloatingLabelBehavior.always,
      textInputAction: TextInputAction.done,
      maxLines: maxLines ?? 3,
      labelText:labelText?? "Any allergies or symptoms?",
      hintText: "write here if you have any allergies or symptoms ...",
      controller: cubit.allergyController,
      validator: validator,
      fillColor: AppColors.white,
      padding: padding,
      contentPadding: ScreenUtil().setWidth(20.w),
      borderSide: BorderSide(color: AppColors.lightGrey, width: .8.w),
      focusedBorderSide: BorderSide(color: AppColors.lavender, width: .8.w),
      errorBorderSide: BorderSide(color: AppColors.red, width: .8.w),
      focusedErrorBorderSide:
          BorderSide(color: AppColors.lightGrey, width: .8.w),
    );
  }
}
