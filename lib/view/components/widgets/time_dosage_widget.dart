import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_model/bloc/health_follow-up/health_form_cubit.dart';
import '../../../view_model/utils/app_colors.dart';
import '../../../view_model/utils/radio_alert_function.dart';
import '../customs/textfeild_custom.dart';
class TimeAndDosageWidget extends StatelessWidget {
  final HealthFormCubit cubit;
  final IconButton iconButton;
  final TextEditingController dosageController;
  final TextEditingController timeController;
  const TimeAndDosageWidget({super.key, required this.cubit, required this.iconButton, required this.dosageController, required this.timeController});

  @override
  Widget build(BuildContext context) {

    return Row(children: [
      Expanded(
        child: CustomTextField(
          errorBorderSide:BorderSide(color: Colors.red, width: .8.w),
          focusedErrorBorderSide:BorderSide(color: AppColors.lightGrey, width: .8.w),
          controller:timeController,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          readOnly: true,
          validator: (value) {
            if (value!.isEmpty) {
              return "Required";
            }
            return null;
          },
          labelText: "Time",
          prefixIcon: Icon(
            Icons.alarm,
            color: AppColors.lightGrey,
            size: 20.sp,
          ),
          hintText: "8:00 AM",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          fillColor: AppColors.white,
          borderSide:
          BorderSide(color: AppColors.lightGrey, width: .8.w),
          focusedBorderSide:
          BorderSide(color: AppColors.lavender, width: .8.w),
          onTap: () async {
            showTimePicker(
                context: context, initialTime: TimeOfDay.now())
                .then((value) {
             timeController.text =
                  value!.format(context).toString();
            });
          },
        ),
      ),
      SizedBox(
        width: ScreenUtil().setWidth(2.w),
      ),
      iconButton,
      SizedBox(
        width: ScreenUtil().setWidth(2.w),
      ),
      Expanded(
        child: CustomTextField(
          autoValidateMode: AutovalidateMode.onUserInteraction,
          hintText: "Ex: 1",
          errorBorderSide:BorderSide(color: Colors.red, width: .8.w),
          focusedErrorBorderSide:BorderSide(color: AppColors.lightGrey, width: .8.w),
          validator: (value) {
            if (value!.isEmpty) {
              return "Required";
            }
            return null;
          },
            controller: dosageController,
          labelText: "Dosage",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          fillColor: AppColors.white,
          keyboardType: TextInputType.number,
          suffixIcon: IconButton(
            onPressed: () async {
              await RadioAlertFunction<String>(
                options: cubit.dosage,
                initialValue: cubit.dosageSelected.toString(),
                onSelected: (value) {
                  cubit.selectDosage(value! as int);
                  dosageController.text = value;
                  Navigator.of(context).pop();
                },
              ).show(context, 'Select Dosage');
            },
            icon: Icon(
              Icons.keyboard_arrow_down,
              size: 22.sp,
            ),
          ),
          borderSide:
          BorderSide(color: AppColors.lightGrey, width: .8.w),
          focusedBorderSide:
          BorderSide(color: AppColors.lavender, width: .8.w),
        ),
      ),
    ]);
  }
}
