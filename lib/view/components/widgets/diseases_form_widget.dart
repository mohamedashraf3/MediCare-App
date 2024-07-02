import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_model/bloc/health_follow-up/health_form_cubit.dart';
import '../../../view_model/utils/app_colors.dart';
import '../customs/textfeild_custom.dart';

class DiseasesFormWidget extends StatelessWidget {
  final HealthFormCubit cubit;
  final EdgeInsets? padding;
  final int? maxLines;
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;

  const DiseasesFormWidget(
      {Key? key,
      required this.cubit,
      this.padding,
      this.maxLines,
      this.labelText,
      this.hintText,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      autoValidateMode: AutovalidateMode.onUserInteraction,
      onTap: () {
        cubit.showMultiSelectModal(
          context,
          items: cubit.diseases,
          selectedItems: cubit.diseases
              .where((disease) =>
                  cubit.selectedDiseases?.contains(disease) ?? false)
              .toList(),
          onConfirm: (selectedDiseases) {
            cubit.selectedDiseases = selectedDiseases.join(", ");
            cubit.diseaseController.text = cubit.selectedDiseases!;
          },
        );
      },
      readOnly: true,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      textInputAction: TextInputAction.done,
      maxLines: maxLines ?? 4,
      labelText: labelText ?? "Select your disease",
      hintText: hintText ?? "Select your disease",
      controller:controller ?? cubit.diseaseController,
      fillColor: AppColors.white,
      contentPadding: ScreenUtil().setWidth(20.w),
      borderSide: BorderSide(color: AppColors.lightGrey, width: .8.w),
      focusedBorderSide: BorderSide(color: AppColors.lavender, width: .8.w),
      errorBorderSide: BorderSide(color: AppColors.red, width: .8.w),
      focusedErrorBorderSide:
          BorderSide(color: AppColors.lightGrey, width: .8.w),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your medical condition';
        }
        return null;
      },
      padding: padding,
    );
  }
}
