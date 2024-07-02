import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:medicare/view_model/utils/images.dart";
import "../../../view_model/utils/app_colors.dart";

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const AppBarCustom({super.key, this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        title:Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
          child: Image.asset(Images.medicare,width:125.w,),
        ),
      ),
    );
  }

}