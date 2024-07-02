import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_model/utils/app_colors.dart';
class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
        padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 14.w)),
        hintText: "Search",
        controller: TextEditingController(),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            CupertinoIcons.search,
            color: AppColors.grey,
            size: 25.sp,
          ),
        ),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        )),
        side: WidgetStatePropertyAll(BorderSide(
          color: AppColors.grey,
          width: 1,
        )),
        shadowColor: WidgetStatePropertyAll(AppColors.white),
        backgroundColor: WidgetStatePropertyAll(AppColors.white),
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          if (value.isEmpty) {
            //validation and request here ya basha
          } else {
            // if fail here :validation and request here ya basha
          }
        });
  }
}
