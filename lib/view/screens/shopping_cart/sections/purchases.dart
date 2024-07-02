import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/listtile_custom.dart';
import 'package:medicare/view_model/bloc/pharmacy/pharmacy_cubit.dart';

import '../../../../view_model/utils/app_colors.dart';
import '../../../../view_model/utils/images.dart';
import '../../../components/customs/text_custom.dart';

class PurchasesSection extends StatelessWidget {
  const PurchasesSection({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = PharmacyCubit.get(context);
    return BlocBuilder<PharmacyCubit, PharmacyState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
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
            leading: Image.asset(Images.capsule),
            title: Column(
              children: [
                Center(
                  child: TextCustom(
                    text: "Panadol Capsule",
                    fontSize: 15,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          cubit.incrementCounter();
                        },
                        icon: Icon(
                          Icons.add_circle_outlined,
                          color: AppColors.lavender,
                          size: 20.sp,
                        )),
                    TextCustom(
                      text: "${cubit.counter}",
                      color: AppColors.darkGrey.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                    IconButton(
                        onPressed: () {
                          cubit.decrementCounter();
                        },
                        icon: Icon(
                          Icons.remove_circle,
                          color: AppColors.lavender,
                          size: 20.sp,
                        )),
                  ],
                ),
              ],
            ),
            trailing: TextCustom(
                text: "18.00",
                fontSize: 12,
                color: AppColors.darkGrey.withOpacity(0.8),
                fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
