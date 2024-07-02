import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/textfeild_custom.dart';
import 'package:medicare/view/components/widgets/allergies_form_widget.dart';
import 'package:medicare/view/components/widgets/diseases_form_widget.dart';
import 'package:medicare/view_model/bloc/health_follow-up/health_form_cubit.dart';
import 'package:medicare/view_model/utils/app_colors.dart';
import 'package:medicare/view_model/utils/radio_alert_function.dart';
import 'package:medicare/view_model/utils/routes.dart';

import '../../../../view_model/utils/images.dart';
import '../../../components/customs/button_custom.dart';
import '../../../components/customs/text_custom.dart';

class HealthConditionScreen extends StatelessWidget {
  const HealthConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = HealthFormCubit.get(context);
    return Scaffold(
      backgroundColor: AppColors.white,
        body: SingleChildScrollView(
      child: Form(
        key: cubit.healthConditionFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(45)),
          child: BlocBuilder<HealthFormCubit, HealthFormState>(
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(40),
                  ),
                  Image.asset(Images.healthCondition, height: 160.h),
                  TextCustom(
                    text: "Please take your time filling this out !",
                    fontWeight: FontWeight.bold,
                    fontSize: 18.5,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(40.h),
                  ),
                  CustomTextField(
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    hintText: "Choose your blood type",
                    focusedErrorBorderSide:
                        BorderSide(color: AppColors.lightGrey, width: .8.w),
                    labelText: "Blood",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    readOnly: true,
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      size: 24.sp,
                    ),
                    controller: cubit.bloodController,
                    onTap: () async {
                      await RadioAlertFunction<String>(
                        options: cubit.blood,
                        initialValue: cubit.bloodSelected,
                        onSelected: (value) {
                          cubit.selectBloodType(value!);
                          cubit.bloodController.text = value;
                          Navigator.of(context).pop();
                        },
                      ).show(context, 'Choose blood type"');
                    },
                    errorBorderSide:
                        BorderSide(color: AppColors.red, width: .8.w),
                    fillColor: AppColors.white,
                    contentPadding: ScreenUtil().setWidth(20.w),
                    borderSide:
                        BorderSide(color: AppColors.lightGrey, width: .8.w),
                    focusedBorderSide:
                        BorderSide(color: AppColors.lavender, width: .8.w),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please choose your blood type';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(40),
                  ),
                  DiseasesFormWidget(cubit: cubit),
                  SizedBox(
                    height: ScreenUtil().setHeight(20.h),
                  ),
                  AllergiesFormWidget(cubit: cubit),
                  SizedBox(
                    height: ScreenUtil().setHeight(20.h),
                  ),
                  ButtonCustom(
                    width: double.infinity,
                    onPressed: () {
                      if (cubit.healthConditionFormKey.currentState!
                          .validate()) {
                        cubit.healthConditionFormKey.currentState!.validate();
                        Navigator.pushNamed(context, NamedRoutes.medicationDetails);
                      }
                    },
                    child: TextCustom(
                        text: "Next",
                        color: AppColors.white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              );
            },
          ),
        ),
      ),
    ));
  }
}
