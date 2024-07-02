import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../view_model/utils/app_colors.dart';
import '../../customs/text_custom.dart';

class CustomizablePharmacyWidget extends StatelessWidget {
  final Widget topRightWidget;
  final Widget? afterNameRow;
  final String name;
  final String? workingTime;
  final Widget? lastWidget;
  final String imagePath;
  final EdgeInsets? padding;

  const CustomizablePharmacyWidget({
    required this.topRightWidget,
    required this.name,
    this.workingTime,
    this.lastWidget,
    required this.imagePath,
    this.afterNameRow,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              TextCustom(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                text: name,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 5.h),
              afterNameRow ?? SizedBox(),
              if (workingTime != null) ...[
                SizedBox(height: 5.h),
                TextCustom(
                  text: workingTime!,
                  fontSize: 11,
                  color: AppColors.lightGrey,
                  fontWeight: FontWeight.normal,
                ),
              ],
              SizedBox(height: 5.h),
              if (lastWidget != null) ...[lastWidget ?? SizedBox()]
            ],
          ),
          topRightWidget,
        ],
      ),
    );
  }
}
