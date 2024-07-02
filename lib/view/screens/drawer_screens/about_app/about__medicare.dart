import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../view_model/utils/app_colors.dart';
import '../../../../view_model/utils/images.dart';

class AboutMedicare extends StatelessWidget {
  const AboutMedicare({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  Images.logo,
                  height: 100.h,
                  width: 120.w,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'About Medicare',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors
                      .black, // Assuming you have a primary color defined
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              // Adds space between title and description
              Text(
                "The proposed bilingual (Arabic-English) Medication Management System Application aims to significantly enhance patient care by offering personalized medication reminders and comprehensive educational resources. This user-friendly app is designed to streamline medication adherence and procurement, ensuring that patients remain consistent with their treatment regimens. By incorporating innovative solutions and support tools, the application seeks to improve accessibility, convenience, and overall health outcomes for a diverse user base, ultimately contributing to a more effective and user-centered healthcare experience.\n \n \t \t \t \t \t \t \t  Developed by: Medicare Team",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors
                      .grey,
                ),
                textAlign: TextAlign
                    .justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
