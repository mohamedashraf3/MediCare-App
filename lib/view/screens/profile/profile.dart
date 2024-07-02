import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/listtile_custom.dart';
import 'package:medicare/view_model/utils/images.dart';

import '../../../view_model/bloc/app/app_cubit.dart';
import '../../../view_model/utils/app_colors.dart';
import '../../components/customs/text_custom.dart';
import '../../components/widgets/bottom_navigator_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    return Scaffold(
      backgroundColor: AppColors.white, // Use scaffold background color from theme
      body: Column(
        children: [
          SizedBox(
            height: 80.h,
          ),
          CircleAvatar(
            radius: 40.r,
            backgroundImage: const AssetImage(
              Images.avatar,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          TextCustom(
            text: "Mohamed Ashraf",
            fontSize: 15.5,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 5.h,
          ),
          TextCustom(
            text: "mohamedashraf@gmail.com",
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.white, // Use surface color from theme
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2.r,
                  blurRadius: 3.r,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    TextCustom(
                      text: "22",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lavender, // Use onSurface color from theme
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextCustom(
                      text: "Age",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey, // Use onSurface color from theme
                    ),
                  ],
                ),
                SizedBox(
                  width: 20.w,
                ),
                Column(
                  children: [
                    TextCustom(
                      text: "A+",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lavender, // Use onSurface color from theme
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextCustom(
                      text: "Blood",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey, // Use onSurface color from theme
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(
                color: AppColors.lightGrey,
                thickness: 1,
              ),
              itemCount: cubit.profileScreenTitles.length,
              itemBuilder: (context, index) => ListTileCustom(
                onTap: () {
                  cubit.setIndexProfile(index: index, context: context);
                },
                leading: Icon(
                  cubit.profileScreenIcons[index],
                  color:AppColors.lavender,
                  size: 30.sp,
                ),
                title: TextCustom(
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  text: cubit.profileScreenTitles[index],
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
