import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/button_custom.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view/components/customs/textfeild_custom.dart';
import 'package:medicare/view/screens/payment_card/payment_card.dart';
import 'package:medicare/view/screens/payment_successful/payment_successful.dart';
import 'package:medicare/view/screens/vodafone_cash/vodafone_cash_screen.dart';
import '../../../view_model/bloc/pharmacy/pharmacy_cubit.dart';
import '../../../view_model/utils/app_colors.dart';

class SelectPaymentScreen extends StatelessWidget {
  const SelectPaymentScreen({Key? key});

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
      body: BlocConsumer<PharmacyCubit, PharmacyState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: cubit.paymentFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  CustomTextField(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    controller: cubit.addressController,
                    contentPadding: 20.w,
                    hintText: "Ex: 4 Street , Kom Hamada",
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Address can't be empty";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    labelText: "Address",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    borderSide:
                        BorderSide(color: AppColors.lightGrey, width: .8.w),
                    errorBorderSide:
                        BorderSide(color: AppColors.red, width: .8.w),
                    focusedErrorBorderSide:
                        BorderSide(color: AppColors.red, width: .8.w),
                    focusedBorderSide:
                        BorderSide(color: AppColors.lavender, width: .8.w),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  TextCustom(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    text: "Payment method",
                    fontSize: 16,
                    color: AppColors.lavender,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ListView.separated(
                    padding: EdgeInsets.only(
                      left: 15.w,
                      right: 30.w,
                    ),
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 30.h,
                      );
                    },
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cubit.paymentMethods.length,
                    itemBuilder: (context, index) {
                      final method = cubit.paymentMethods[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Radio<String>(
                          value: method['value'],
                          groupValue: cubit.selectedMethod,
                          onChanged: (value) {
                            cubit.selectedMethod = value!;
                            cubit.selectPayMethod(value);
                          },
                        ),
                        title: method['widget'],
                      );
                    },
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  ButtonCustom(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      width: double.infinity,
                      onPressed: () {
                        if (cubit.paymentFormKey.currentState!.validate()) {
                          if (cubit.selectedMethod == "Credit /Debit card") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentCardScreen(),
                                ));
                          } else if (cubit.selectedMethod == "Vodafone cash") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VodafoneCashScreen(),
                                ));
                          } else {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PaymentSuccessfulScreen(
                                          title: "Your order is completed",
                                          message:
                                              "Our pharmacy will be contacting you shortly to arrange the delivery of your medicines.",
                                        )),
                                (Route<dynamic> route) => false);
                          }
                        }
                      },
                      child: TextCustom(
                        text: 'Pay now',
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
