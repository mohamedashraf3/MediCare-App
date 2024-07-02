import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view/screens/pharmacy_medicines/sections/pharmacy_medicines_card.dart';
import 'package:medicare/view_model/bloc/pharmacy/pharmacy_cubit.dart';
import 'package:medicare/view_model/utils/app_colors.dart';
import '../../../view_model/utils/routes.dart';
import '../../components/customs/search_bar_custom.dart';
import '../../components/widgets/bottom_navigator_widget.dart';

class PharmacyMedicinesScreen extends StatelessWidget {
  const PharmacyMedicinesScreen({super.key, required this.pharmacyName});
  final String pharmacyName;

  List<Map<String, dynamic>> getMedicines() {
    return[
      {
        "Name": "Paracetamol",
        "Price": 20.00,
        "ProductId": 1
      },
      {
        "Name": "Ibuprofen",
        "Price": 35.00,
        "ProductId": 2
      },
      {
        "Name": "Amoxicillin",
        "Price": 50.00,
        "ProductId": 3
      },
      {
        "Name": "Cetirizine",
        "Price": 25.00,
        "ProductId": 4
      },
      {
        "Name": "Aspirin",
        "Price": 15.00,
        "ProductId": 5
      },
      {
        "Name": "Metformin",
        "Price": 45.00,
        "ProductId": 6
      },
      {
        "Name": "Loratadine",
        "Price": 30.00,
        "ProductId": 7
      },
      {
        "Name": "Omeprazole",
        "Price": 40.00,
        "ProductId": 8
      },
      {
        "Name": "Atorvastatin",
        "Price": 55.00,
        "ProductId": 9
      },
      {
        "Name": "Metronidazole",
        "Price": 35.00,
        "ProductId": 10
      },
      {
        "Name": "Azithromycin",
        "Price": 60.00,
        "ProductId": 11
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
  List<Map<String, dynamic>> medicines = getMedicines();
    var cubit = PharmacyCubit.get(context);
    return BlocBuilder<PharmacyCubit, PharmacyState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.white,
            scrolledUnderElevation: 0,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50.h,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, NamedRoutes.shoppingCart);
                          },
                          icon: Stack(
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 40.sp,
                                color: AppColors.lavender,
                              ),
                              Positioned(
                                top: 0, // Top padding
                                right: 0, // Right alignment
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  // Add some padding for the badge
                                  decoration: BoxDecoration(
                                    color: AppColors.red,
                                    // Background color for the badge
                                    borderRadius: BorderRadius.circular(
                                        10), // Rounded corners
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 20,
                                    minHeight: 20,
                                    maxHeight: 17.h,
                                    maxWidth: 40.w,
                                  ),
                                  child: Text(
                                    "${cubit.addToCart.length}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Image.asset(
                            "assets/images/2.png",
                            fit: BoxFit.contain,
                            height: 80.h,
                          ),
                        ],
                      ),
                      Container(
                        height: 50.h,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.bookmark_border,
                              color: AppColors.lavender,
                              size: 40.sp,
                            )),
                      ),
                    ],
                  ),
                  Center(
                    child: TextCustom(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      text: "Welcome in $pharmacyName",
                      fontSize: 14.7.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.placemark,
                            color: AppColors.darkGrey.withOpacity(0.8),
                            size: 20.sp,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          TextCustom(
                            text: "123 Main Street, City",
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkGrey.withOpacity(0.8),
                          ),
                        ],
                      ),
                      TextCustom(
                        text: "8:00AM-21:00PM",
                        fontSize: 9.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGrey.withOpacity(0.8),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextCustom(
                    text: "Find a medication",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lavender,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 35.h,
                    child: CustomSearchBar(),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextCustom(
                    text: "popular Medications",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lavender,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Flexible(
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          childAspectRatio: 0.8.h,
                        ),
                        itemBuilder: (context, index) => PharmacyMedicinesCard(
                              onAddToCartTap: () {
                                cubit.addToCartList(index);
                              }, medicinesName: medicines[index]["Name"], price: medicines[index]["Price"].toString(),
                            ),
                        itemCount: medicines.length),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavBar(),
        );
      },
    );
  }
}
