import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicare/view/components/customs/button_custom.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view/components/widgets/diseases_form_widget.dart';
import 'package:medicare/view_model/bloc/health_follow-up/health_form_cubit.dart';
import 'package:medicare/view_model/utils/images.dart';

import '../../../../view_model/utils/app_colors.dart';

class EditeHealthConditionScreen extends StatelessWidget {
  const EditeHealthConditionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var cubit = HealthFormCubit.get(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
      scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: cubit.editeHealthConditionFormKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Images.heartAdd, height: 75.h),
                SizedBox(height: 20.h),
                TextCustom(
                    text: "Manage your Health conditions",
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                SizedBox(height: 75.h),
                DiseasesFormWidget(
                  controller: cubit.returnStoredMedication?[0]['disease'],
                    labelText: "Edite your Disease",
                    cubit: cubit,
                    maxLines: 6,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    )),
                SizedBox(height: 75.h),
                ButtonCustom(
                    onPressed: () {
                      if (cubit.editeHealthConditionFormKey.currentState!
                          .validate()) {
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
