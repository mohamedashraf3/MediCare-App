import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/enable_disable_notification.dart';
import 'package:medicare/view/components/customs/listtile_custom.dart';
import 'package:medicare/view/components/customs/text_custom.dart';

import '../../../../view_model/bloc/app/app_cubit.dart';
import '../../../../view_model/utils/app_colors.dart';

class NotificationSetting extends StatelessWidget {
  const NotificationSetting({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:AppColors.white,
        scrolledUnderElevation: 0,
        title: ListTileCustom(
          leading: Icon(
            Icons.notifications_outlined,
            color: AppColors.lavender,
            size: 30.sp,
          ),
          title: TextCustom(
            text: "Notifications",
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.lavender,
          ),
        ),
      ),
      body: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
        return ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            SizedBox(
              height: 20.h,
            ),
            EnableDisableNotification(
              text: "Temporarily disable all notifications",
              value:cubit.isDisableAllNotification, onChanged: (value) {
              cubit.toggleDisableAllNotification();
            },),
            SizedBox(
              height: 20.h,
            ),
            Divider(
              height: 10.h,
              thickness: 1,
              endIndent: 20.w,
              indent: 20.w,
            ),
            SizedBox(
              height: 5.h,
            ),
            TextCustom(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              text: "Type of Notifications",
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.lavender,
            ),
            ListView.builder(
              padding: EdgeInsets.only(
                left: 15.w,
                right: 30.w,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cubit.notificationTypes.length,
              itemBuilder: (context, index) {
                final method = cubit.notificationTypes[index];
                return ListTileCustom(
                  leading: Radio<String>(
                    value: method,
                    groupValue: cubit.selectedNotificationType,
                    onChanged: (value) {
                      cubit.selectedNotificationType = value!;
                      cubit.updateNotificationType(type: value);
                    },
                  ),
                  onTap: () {
                    cubit.selectedNotificationType = method;
                    cubit.updateNotificationType(type: method);
                  },
                  title: TextCustom(text: "$method",
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                );
              },
            ),
            SizedBox(
              height: 5.h,
            ),
            Divider(
              height: 10.h,
              thickness: 1,
              endIndent: 20.w,
              indent: 20.w,
            ),
            EnableDisableNotification(
              text: "Medication Reminder",
                value:cubit.isMedicationReminder ,
                onChanged: (value) {
                cubit.toggleMedicationReminder();
                }),
            SizedBox(
              height: 20.h,
            ),
            EnableDisableNotification(
              text: "Missed doses reminder",
                value:cubit.isMissedDoseNotification ,
                onChanged: (value) {
                cubit.toggleMissedDoseNotification();
                }),
            SizedBox(
              height: 20.h,
            ),
            EnableDisableNotification(
              text: "New Pharmacies and Doctors Alerts",
                value:cubit.isNewPharmacyDoctorNotification ,
                onChanged: (value) {
                cubit.toggleNewPharmacyDoctorNotification();
                }),
            SizedBox(
              height: 20.h,
            ),
          ],
        );
      }),
    );
  }
}
