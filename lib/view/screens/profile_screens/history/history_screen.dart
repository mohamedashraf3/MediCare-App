import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/listtile_custom.dart';

import '../../../../view_model/utils/app_colors.dart';
import '../../../components/customs/text_custom.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  List<Map<String, dynamic>> getFakeData() {
    return [
      {
        "date": "Today,2023-05-25",
        "actions": [
          {
            "time": "08:00 AM",
            "description": "One Containerize tablet was taken"
          },
          {
            "time": "10:00 AM",
            "description":
                "The omega-3 medication dosage was postponed for 15 minutes"
          },
        ],
      },
      {
        "date": "Yesterday,2023-05-26",
        "actions": [
          {
            "time": "06:30 AM",
            "description":
                "Two packages of paracetamol were purchased for \$1.48"
          },
          {
            "time": "07:00 AM",
            "description": "One Containerize tablet was taken"
          },
          {
            "time": "10:00 AM",
            "description":
                "The omega-3 medication dosage was postponed for 15 minutes"
          },
        ],
      },
      {
        "date": "2023-05-27",
        "actions": [
          {
            "time": "09:00 AM",
            "description":
                "Two Loratadine tablets were added to be taken daily for ten days."
          },
        ],
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> historyData = getFakeData();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTileCustom(
              leading: Icon(
                Icons.history,
                color: AppColors.lavender,
                size: 35.sp,
              ),
              title: TextCustom(
                text: "History",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.lavender,
              ),
            ),
            SizedBox(height: 14.h),
            ...historyData.map((dayData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    text: dayData["date"],
                    padding: EdgeInsets.symmetric( horizontal: 12.w),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  ...dayData["actions"].map((action) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 12.w,
                      ),
                      margin:
                          EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextCustom(
                            text: action["description"],
                            color: AppColors.grey,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(height: 6.h),
                          TextCustom(
                            text: action["time"],
                            fontSize: 12,
                            color: AppColors.grey,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 14.h),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
