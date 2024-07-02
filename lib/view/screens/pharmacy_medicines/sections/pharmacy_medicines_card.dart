import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/widgets/customizable_pharmacy_widget/customizable_pharmacy_widget.dart';

import '../../../../view_model/utils/app_colors.dart';
import '../../../components/customs/text_custom.dart';

class PharmacyMedicinesCard extends StatelessWidget {
  final void Function()? onAddToCartTap;
  final String medicinesName;
  final String price;
  const PharmacyMedicinesCard({super.key, required this.onAddToCartTap, required this.medicinesName, required this.price});

  @override
  Widget build(BuildContext context) {
    return CustomizablePharmacyWidget(
      topRightWidget: TextCustom(
        text: "$price",
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        color: AppColors.darkGrey.withOpacity(0.8),
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      name: medicinesName,
      imagePath: "assets/images/2.png",
      lastWidget: Material(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onAddToCartTap,
          borderRadius: BorderRadius.circular(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextCustom(
                  text: "Add to cart",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lavender),
              SizedBox(
                width: 15.w,
              ),
              Icon(
                Icons.add_circle,
                color: AppColors.lavender,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 10.h),
    );
  }
}
