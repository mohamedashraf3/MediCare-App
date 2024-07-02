import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/widgets/customizable_pharmacy_widget/customizable_pharmacy_widget.dart';

import '../../../../view_model/bloc/pharmacy/pharmacy_cubit.dart';
import '../../../../view_model/utils/app_colors.dart';
import '../../../../view_model/utils/routes.dart';
import '../../../components/customs/text_custom.dart';

class PharmacyCard extends StatelessWidget {
  final Widget topRightWidget;
  final String PharmacyName;
  final String Location;
  final String Services;
  final double Rating;
  final void Function() onTap;

  const PharmacyCard({
    super.key,
    required this.topRightWidget,
    required this.PharmacyName,
    required this.Location,
    required this.Services,
    required this.Rating, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: CustomizablePharmacyWidget(
        topRightWidget: topRightWidget,
        name: PharmacyName,
        afterNameRow: Row(
          children: [
            Icon(Icons.location_on_rounded, color: AppColors.lightGrey),
            SizedBox(width: 2.w),
            Flexible( // or use Expanded
              child: TextCustom(
                text: Location,
                fontSize: 11,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.ellipsis, // Handle overflow
              ),
            ),
          ],
        ),
        lastWidget: RatingStars(
          axis: Axis.horizontal,
          value: Rating,
          starCount: 5,
          starSize: 15.sp,
          valueLabelColor: const Color(0xff9b9b9b),
          valueLabelTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 12.0,
          ),
          valueLabelRadius: 10,
          maxValue: 5,
          starSpacing: 2,
          maxValueVisibility: false,
          valueLabelVisibility: false,
          animationDuration: Duration(milliseconds: 1000),
          valueLabelPadding: const EdgeInsets.symmetric(
            vertical: 1,
            horizontal: 8,
          ),
          valueLabelMargin: const EdgeInsets.only(right: 8),
          starOffColor: const Color(0xffe7e8ea),
          starColor: Colors.yellow,
        ),
        workingTime: Services,
        imagePath: "assets/images/2.png",
      ),
    );
  }
}
