import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/listtile_custom.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import '../../../view_model/utils/app_colors.dart';
import '../../components/widgets/bottom_navigator_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  List<Map<String, dynamic>> getNotification() {
    return [
      {
        "title": "Potential drug interaction detected",
        "details": "Propranolol and albuterol interaction may cause adverse effects. Consult a doctor.",
        "time": "10:00 AM"
      },
      {
        "title": "Medication Reminder",
        "details": "Time to take your morning dose of Metformin.",
        "time": "7:00 AM"
      },
      {
        "title": "Appointment Reminder",
        "details": "Your appointment with Dr. Smith is scheduled for 2:00 PM today.",
        "time": "8:00 AM"
      },
      {
        "title": "Lab Results Ready",
        "details": "Your recent blood test results are now available. Check the app for details.",
        "time": "9:30 AM"
      },
      {
        "title": "Prescription Refill Due",
        "details": "Refill your Atorvastatin prescription before it runs out.",
        "time": "1:00 PM"
      },
      {
        "title": "New Health Tip",
        "details": "Drinking water before meals can aid digestion and help manage weight.",
        "time": "2:30 PM"
      },
      {
        "title": "Follow-Up Required",
        "details": "Schedule a follow-up appointment to review your cholesterol levels.",
        "time": "11:00 AM"
      },
      {
        "title": "Health Check Alert",
        "details": "It's time for your annual health check-up. Schedule an appointment soon.",
        "time": "4:00 PM"
      },
      {
        "title": "New Message from Doctor",
        "details": "You have a new message from Dr. Lee. Check the app for more details.",
        "time": "5:00 PM"
      },
      {
        "title": "Dietary Advice",
        "details": "Consider incorporating more fiber into your diet for better heart health.",
        "time": "6:00 PM"
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> notifications = getNotification();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: TextCustom(
          text: "Notifications",
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.lavender,
        ),
        leading: SizedBox(),
        actions: [

        ],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> notification = notifications[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: ListTileCustom(
              leading: Icon(
                Icons.info_rounded,
                size: 40.sp,
                color: AppColors.lavender,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    text: notification["title"],
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextCustom(
                    text: notification["details"],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextCustom(
                    text: notification["time"],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lavender,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
