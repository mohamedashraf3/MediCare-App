import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicare/view_model/bloc/app/app_cubit.dart';

import '../../../view_model/utils/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return BottomNavigationBar(

          onTap: (int value) {
            cubit.setIndexBottomNav(index: value, context: context);
          },
          selectedFontSize: 12.sp,
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          unselectedFontSize: 12.sp,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.lavender,
          unselectedItemColor: AppColors.grey,
          showUnselectedLabels: true,
          elevation: 12,
          iconSize: 25.sp,
          currentIndex: cubit.currentIndex,
          selectedLabelStyle: TextStyle(
            fontFamily: "Poppins",
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: "Poppins",
            color: AppColors.grey,
          ),
          useLegacyColorScheme: true,
          items: [
            BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.house), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.bell,
                ),
                label: "Notification"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle,
                  size: 40.sp,
                  color: AppColors.lavender,
                ),
                label: "",
                backgroundColor: AppColors.lavender),
            BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.commentDots,
                ),
                label: "Chat"),
            BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.user,
                ),
                label: "profile"),
          ],
        );
      },
    );
  }
}
