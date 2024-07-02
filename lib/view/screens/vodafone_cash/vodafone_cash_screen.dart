import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/button_custom.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view/components/customs/textfeild_custom.dart';

import '../../../view_model/bloc/pharmacy/pharmacy_cubit.dart';
import '../../../view_model/utils/app_colors.dart';
import '../payment_successful/payment_successful.dart';

class VodafoneCashScreen extends StatelessWidget {
  const VodafoneCashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = PharmacyCubit.get(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: cubit.vodafoneCashFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/img_2.png",
                height: 120,
                width: double.infinity,
              ),
              SizedBox(
                height: 20.h,
              ),
              TextCustom(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                text:
                    "Transfer 251 EGP to my Vodafone Cash wallet using this number :",
                fontWeight: FontWeight.bold,
                fontSize: 13.5,
              ),
              Center(
                child: TextCustom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                  text: "01025655389",
                  color: AppColors.lavender,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextCustom(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                text:
                    "After sending the money \n please fill the sender's number : ",
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField(
                controller: cubit.senderNumberController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "sender's number can't be empty";
                  } else if (value.length != 11) {
                    return "sender's number must be 11 digits";
                  }
                  return null;
                },
                hintText: "Sender’s number goes here",
                autoValidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                prefixIcon: Icon(
                  Icons.phone_iphone,
                  color: AppColors.lavender,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                ),
              ),
              TextCustom(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                text:
                    "Please attach a screenshot of the payment or image of the receipt here :",
                fontWeight: FontWeight.bold,
              ),
              BlocBuilder<PharmacyCubit, PharmacyState>(
                builder: (context, state) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 30.w,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        border: Border.all(width: 1, color: AppColors.grey)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        cubit.takePhotoFromUser(context: context);
                      },
                      child: Visibility(
                        visible: cubit.image == null,
                        replacement: Image.file(
                          File(cubit.image?.path ?? ""),
                          width: double.infinity,
                          isAntiAlias: true,
                          height: 180.h,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo,
                              size: 150.sp,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            TextCustom(
                              text: "attach a screenshot of the payment",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              ButtonCustom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.w, vertical: 5.h),
                  onPressed: () {
                    if (cubit.vodafoneCashFormKey.currentState!.validate()&&cubit.image!=null) {
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(
                          builder: (context) => const PaymentSuccessfulScreen()), (
                          route) => false);
                    }},
                  width: double.infinity,
                  child: TextCustom(
                    text: "Submit",
                    fontSize: 15.7,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
