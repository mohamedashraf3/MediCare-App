import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import '../../../../view_model/utils/app_colors.dart';

class DoctorListCard extends StatelessWidget {
  final String name;
  final String experience;
  final String specialization;
  final String address;
  final double rating;
  final void Function()? onTap;

  const DoctorListCard({
    super.key,
    this.onTap,
    required this.name,
    required this.specialization,
    required this.address,
    required this.rating,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30.w,  // Reduced size for compact card
              backgroundColor: AppColors.lightGrey.withOpacity(0.5),
              child: Icon(
                Icons.person,
                size: 30.w,  // Reduced size for compact card
                color: AppColors.lavender,
              ),
            ),
            SizedBox(width: 10.w),  // Reduced spacing for compact card
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    text: name,
                    fontSize: 14.sp,  // Reduced font size for compact card
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  TextCustom(
                    text: experience,
                    fontSize: 12.sp,  // Reduced font size for compact card
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: TextCustom(
                          text: specialization,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(
                        Icons.location_on,
                        color: AppColors.grey,
                        size: 12.sp,
                      ),
                      SizedBox(width: 4.w),
                      Flexible(
                        flex: 2,
                        child: TextCustom(
                          text: address,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      RatingStars(
                        axis: Axis.horizontal,
                        value: rating,
                        starCount: 5,
                        starSize: 14.sp,  // Reduced size for compact card
                        valueLabelColor: const Color(0xff9b9b9b),
                        valueLabelTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.0,
                        ),
                        valueLabelRadius: 10,
                        maxValue: 5,
                        starSpacing: 2.w,
                        maxValueVisibility: false,
                        valueLabelVisibility: false,
                        animationDuration: Duration(milliseconds: 500),
                        valueLabelPadding: const EdgeInsets.symmetric(
                            vertical: 1,
                            horizontal: 8
                        ),
                        valueLabelMargin: const EdgeInsets.only(right: 8),
                        starOffColor: const Color(0xffe7e8ea),
                        starColor: Colors.amber,
                      ),
                      SizedBox(width: 6.w),
                      TextCustom(
                        text: "$rating",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
