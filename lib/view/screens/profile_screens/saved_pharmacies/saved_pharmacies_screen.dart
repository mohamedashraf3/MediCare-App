import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../view_model/bloc/pharmacy/pharmacy_cubit.dart';
import '../../../../view_model/utils/app_colors.dart';
import '../../../components/customs/search_bar_custom.dart';
import '../../../components/customs/text_custom.dart';
import '../../pharmacy/sections/pharmacy_cards.dart';
import '../../pharmacy_medicines/pharmacy_medicines_screen.dart';

class SavedPharmaciesScreen extends StatelessWidget {
  const SavedPharmaciesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = PharmacyCubit.get(context);
    cubit.getSavedPharmacies();

    return BlocBuilder<PharmacyCubit, PharmacyState>(
      builder: (context, state) {
        var pharmacySaved=cubit.pharmaciesList;
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
                SizedBox(height: 35.h, child: CustomSearchBar()),
                SizedBox(height: 25.h),
                TextCustom(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  text: "Saved pharmacies",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lavender,
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                    ),
                    itemBuilder: (context, index) => PharmacyCard(
                      topRightWidget: IconButton(
                        onPressed: () {
                          cubit.savePharmacy(pharmacySaved[index] as int);
                        },
                        icon: Icon(
                          cubit.isPharmacySaved(index)
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: cubit.isPharmacySaved(pharmacySaved[index] as int)
                              ? AppColors.gold
                              : AppColors.lavender,
                          size: 25.sp,
                        ),
                      ),
                      PharmacyName:pharmacySaved[index].name??"",
                      Location: pharmacySaved[index].location??"",
                      Services: pharmacySaved[index].services??"",
                      Rating: pharmacySaved[index].rate??0,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PharmacyMedicinesScreen(
                               pharmacyName: '',
                            ),
                          ),
                        );
                      },
                    ),
                    itemCount: pharmacySaved.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
