
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/text_custom.dart';

import '../../../view_model/utils/app_colors.dart';

class PharmacyDoctorWidget extends StatelessWidget {
  final String text;
  final String image;
  final void Function()? onTap;

  const PharmacyDoctorWidget(
      {super.key, required this.text, required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextCustom(
                text: text,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.lavender,
              ),
              SizedBox(
                height: 8,
              ),
              Image.asset(
                image,
                width: 135.w,
                height: 80.h,
              ),
            ]),
      ),
    );
  }
}

