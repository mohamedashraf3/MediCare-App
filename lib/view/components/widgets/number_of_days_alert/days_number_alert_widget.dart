import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../view_model/bloc/health_follow-up/health_form_cubit.dart';
import '../../../../view_model/utils/app_colors.dart';
import '../../customs/button_custom.dart';
import '../../customs/text_custom.dart';

class AlertWidget extends StatelessWidget {
  final HealthFormCubit cubit;
  final Widget? item1;
  final Widget? item2;
  final Widget? item3;
  final Widget? item4;
  final Widget? item5;
  final Key? formKey;
  final EdgeInsetsGeometry? padding;
  final void Function()? onPressed;
  final String? buttonText;

  const AlertWidget(
      {super.key,
      required this.cubit,
      this.item1,
      this.item2,
      this.item3,
      this.item4,
      this.item5,
      this.onPressed,
      this.formKey, this.padding, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        width: ScreenUtil().setWidth(300),
        child: Padding(
          padding: padding?? EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(20),
              vertical: ScreenUtil().setHeight(10)),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  item1 ?? SizedBox(),
                  item2 ?? SizedBox(),
                  item3 ?? SizedBox(),
                  item4 ?? SizedBox(),
                  item5 ?? SizedBox(),
                  SizedBox(
                    height: ScreenUtil().setHeight(15.h),
                  ),
                  ButtonCustom(
                      width: double.infinity,
                      onPressed: onPressed,
                      child: TextCustom(
                        text: buttonText ??"Done",
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
