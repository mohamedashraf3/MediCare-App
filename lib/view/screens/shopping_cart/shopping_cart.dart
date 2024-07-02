import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/button_custom.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view/screens/shopping_cart/sections/purchases.dart';

import '../../../view_model/utils/app_colors.dart';
import '../../../view_model/utils/routes.dart';
import '../../components/customs/listtile_custom.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading: Icon(
              Icons.shopping_cart_outlined,
              size: 40.sp,
              color: AppColors.lavender,
            ),
            title: TextCustom(
              text: "Shopping Cart",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.lavender,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return PurchasesSection();
                }),
          ),
          Container(
            decoration: BoxDecoration(),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  thickness: 1,
                  color: AppColors.lightGrey,
                ),
                ListTileCustom(
                  trailing: TextCustom(
                    text: "10.00",
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGrey.withOpacity(.8),
                  ),
                  leading: TextCustom(
                    text: "Shipping charges",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGrey.withOpacity(.8),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: AppColors.lightGrey,
                ),
                ListTileCustom(
                  trailing: TextCustom(
                    text: "28.00 EGP",
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGrey.withOpacity(.8),
                  ),
                  leading: TextCustom(
                    text: "Total",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGrey.withOpacity(.8),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: AppColors.lightGrey,
                ),
                ButtonCustom(
                    padding:
                        EdgeInsets.symmetric(vertical: 25.h, horizontal: 40.w),
                    width: double.infinity,
                    onPressed: () {
                      Navigator.pushNamed(context, NamedRoutes.selectPayment);
                    },
                    child: TextCustom(
                      text: "Confirm",
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
