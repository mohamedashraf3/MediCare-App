import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/widgets/allergies_form_widget.dart';

import '../../../../view_model/bloc/health_follow-up/health_form_cubit.dart';
import '../../../../view_model/utils/app_colors.dart';
import '../../../../view_model/utils/images.dart';
import '../../../components/customs/button_custom.dart';
import '../../../components/customs/text_custom.dart';

class AllergiesInformationScreen extends StatelessWidget {
  const AllergiesInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = HealthFormCubit.get(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: cubit.editeAllergyFormKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.allergy,
                ),
                SizedBox(height: 20.h),
                TextCustom(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    text:
                        "To ensure your safety, it is helpful to know if you have any allergies to any medication",
                    fontSize: 16,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold),
                SizedBox(height: 75.h),
                AllergiesFormWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Allergies can't be empty!";
                    }
                    return null;
                  },
                  maxLines: 6,
                  labelText: "What kind of allergies do you get?",
                  cubit: cubit,
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                ),
                SizedBox(height: 75.h),
                ButtonCustom(
                    onPressed: () {
                      if (cubit.editeAllergyFormKey.currentState!.validate()) {
                        Navigator.pop(context);
                      }
                    },
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    width: double.infinity,
                    child: TextCustom(
                        text: "Save",
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
