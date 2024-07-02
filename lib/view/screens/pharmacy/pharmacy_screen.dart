import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/search_bar_custom.dart';
import 'package:medicare/view/screens/pharmacy/sections/pharmacy_cards.dart';

import '../../../view_model/bloc/pharmacy/pharmacy_cubit.dart';
import '../../../view_model/utils/app_colors.dart';
import '../../components/customs/text_custom.dart';
import '../../components/widgets/bottom_navigator_widget.dart';
import '../pharmacy_medicines/pharmacy_medicines_screen.dart';

class PharmacyScreen extends StatelessWidget {
  const PharmacyScreen({super.key});


  @override
  Widget build(BuildContext context) {
    var cubit = PharmacyCubit.get(context);
    var pharmacy=cubit.pharmaciesList;
    return BlocProvider.value(
      value: cubit..getPharmacies(),
      child: BlocBuilder<PharmacyCubit, PharmacyState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.white,
              scrolledUnderElevation: 0,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    text: "Find a pharmacy",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lavender,
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(height: 35.h, child: CustomSearchBar()),
                  SizedBox(height: 25.h),
                  TextCustom(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    text: "Near to you",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lavender,
                  ),
                  SizedBox(height: 20.h),
                 pharmacy.isEmpty? Center(child: CircularProgressIndicator()): Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) =>
                          PharmacyCard(
                            topRightWidget: IconButton(
                              onPressed: () {
                                cubit.savePharmacy(index);
                              },
                              icon: Icon(
                                cubit.isPharmacySaved(index)
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: cubit.isPharmacySaved(index)
                                    ? AppColors.gold
                                    : AppColors.lavender,
                                size: 25.sp,
                              ),
                            ),
                            PharmacyName: pharmacy[index].name??"pharmacy name",
                            Location:pharmacy[index].location??"location",
                            Services: pharmacy[index].services??"services",
                            Rating: pharmacy[index].rate??0.0,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PharmacyMedicinesScreen(
                                            pharmacyName: pharmacy[index].name??"pharmacy name",
                                          )));
                            },
                          ),
                      itemCount: pharmacy.length,
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavBar(),
          );
        },
      ),
    );
  }
}
