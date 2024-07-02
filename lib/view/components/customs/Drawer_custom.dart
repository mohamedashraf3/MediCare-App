import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view_model/data/local/shared_prefrence/shared_keys.dart';

import '../../../view_model/bloc/app/app_cubit.dart';
import '../../../view_model/data/local/shared_prefrence/shared_prefrence.dart';
import '../../../view_model/utils/app_colors.dart';
import '../../../view_model/utils/images.dart';
import 'listtile_custom.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            duration: Duration(milliseconds: 500),
            curve: Curves.elasticIn,
            decoration: BoxDecoration(
              color: AppColors.lavender,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
              ),
              shape: BoxShape.rectangle,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundImage: AssetImage(Images.avatar),
                ),
                SizedBox(width: 20),
                Expanded(
                  // Wrap the Row with Expanded
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustom(
                          text: "Mohamed ",
                          color: AppColors.white,
                          fontWeight: FontWeight.bold),
                      SizedBox(height: 5),
                      TextCustom(
                          text: "midoashraf@gmail.com",
                          color: AppColors.white,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocConsumer<AppCubit, AppState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return ListTileCustom(
                      onTap: () {
                        if (index == 1) {
                          cubit.shareAppLink();
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => cubit.DrawerScreens[index],
                            ),
                          );
                        }
                      },
                      item: cubit.items[index],
                      leading: Icon(
                        cubit.icons[index],
                        color: AppColors.black,
                        size: 24.sp,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: 12.h,
                  ),
                  itemCount: cubit.items.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
