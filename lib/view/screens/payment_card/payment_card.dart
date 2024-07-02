import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/extra/card_type.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/button_custom.dart';
import 'package:medicare/view/components/customs/textfeild_custom.dart';
import '../../../view_model/bloc/pharmacy/pharmacy_cubit.dart';
import '../../../view_model/utils/app_colors.dart';
import '../../components/customs/text_custom.dart';
import '../payment_successful/payment_successful.dart';

class PaymentCardScreen extends StatelessWidget {
  const PaymentCardScreen({super.key});

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
        child: BlocBuilder<PharmacyCubit, PharmacyState>(
          builder: (context, state) {
            return Form(
              key: cubit.paymentCardFormKey,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      cubit.showBackSideCard();
                    },
                    child: CreditCard(
                      width: MediaQuery.of(context).size.width,
                      cardNumber: cubit.cardNumberController.text,
                      cardExpiry: cubit.expiryDateController.text,
                      cardHolderName: cubit.holderNameController.text,
                      cvv: cubit.cvvController.text,
                      cardType: cubit.cardType,
                      showBackSide: cubit.showBackSide,
                      frontBackground: CardBackgrounds.black,
                      backBackground: CardBackgrounds.white,
                      showShadow: true,
                      textExpDate: 'Exp. Date',
                      textExpiry: cubit.expiryDateController.text,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    controller: cubit.holderNameController,
                    labelName: "Card holder name",
                    hintText: "Mohammed Ashraf",
                    onChanged: (value) {
                      cubit.onChangeCardPayController();
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name can't be empty";
                      } else if (!RegExp(
                              r"([a-zA-Z]{2,}\s[a-zA-Z]{2,}(?:\s[a-zA-Z]{2,})*)")
                          .hasMatch(value)) {
                        return 'Enter a valid full name (e.g., John Doe)';
                      }
                      return null;
                    },
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                      LengthLimitingTextInputFormatter(30),
                    ],
                  ),
                  CustomTextField(
                    controller: cubit.cardNumberController,
                    labelName: "Card number",
                    onChanged: (value) {
                      cubit.onChangeCardPayController();
                    },
                    hintText: "1234 5678 9012 3456",
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (creditCardNumber) {
                      if (creditCardNumber!.isEmpty) {
                        return "Card number can't be empty";
                      } else if (!RegExp(
                              r"^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$")
                          .hasMatch(creditCardNumber.replaceAll(' ', ''))) {
                        return 'Enter a valid card number';
                      } else if (RegExp(r"^4[0-9]{12}(?:[0-9]{3})?$")
                          .hasMatch(creditCardNumber)) {
                        cubit.cardType = CardType.visa;
                      } else if (RegExp(r"^5[1-5][0-9]{14}$")
                          .hasMatch(creditCardNumber)) {
                        cubit.cardType = CardType.masterCard;
                      } else if (RegExp(r"^3[47][0-9]{13}$")
                          .hasMatch(creditCardNumber)) {
                        cubit.cardType = CardType.americanExpress;
                      } else if (RegExp(r"^3(?:0[0-5]|[68][0-9])[0-9]{11}$")
                          .hasMatch(creditCardNumber)) {
                        cubit.cardType = CardType.dinersClub;
                      } else if (RegExp(r"^6(?:011|5[0-9]{2})[0-9]{12}$")
                          .hasMatch(creditCardNumber)) {
                        cubit.cardType = CardType.discover;
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                    ],
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: cubit.expiryDateController,
                          labelName: "Expiry date",
                          hintText: "MM/YY",
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Expiry date can't be empty";
                            }
                            final parts = value.split('/');
                            if (parts.length == 2) {
                              final month = int.tryParse(parts[0]);
                              final year = int.tryParse(parts[1]);
                              if (month == null ||
                                  year == null ||
                                  month < 1 ||
                                  month > 12 ||
                                  year < 0) {
                                return "Invalid expiry date";
                              }
                              // Check if it's a future date
                              final currentYear = DateTime.now().year % 100;
                              final currentMonth = DateTime.now().month;
                              if (year < currentYear ||
                                  (year == currentYear &&
                                      month < currentMonth)) {
                                return "Expiry date must be in the future";
                              }
                            } else {
                              return "Invalid expiry date";
                            }
                            return null;
                          },
                          padding: EdgeInsets.only(
                            left: 30.w,
                            right: 10.w,
                            top: 15.h,
                            bottom: 15.h,
                          ),
                          onChanged: (value) {
                            cubit.onChangeCardPayController();
                          },
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                          onChanged: (value) {
                            cubit.onChangeCardPayController();
                          },
                          controller: cubit.cvvController,
                          padding: EdgeInsets.only(
                            left: 10.w,
                            right: 30.w,
                            top: 15.h,
                            bottom: 15.h,
                          ),
                          obscureText: true,
                          obscuringCharacter: "x",
                          labelName: "CVV",
                          hintText: "123",
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "CVV can't be empty";
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ButtonCustom(
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            width: double.infinity,
                            onPressed: () {
                              if (cubit.paymentCardFormKey.currentState!.validate()) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PaymentSuccessfulScreen()),
                                        (route) => false);
                              }
                              },
                            child: TextCustom(
                                text: "Pay Now",
                                color: Colors.white,
                                fontSize: 15.7,
                                fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: ButtonCustom(
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            width: double.infinity,
                            onPressed: cubit.isCardSaved
                                ? null
                                : () {
                                    if (cubit.paymentCardFormKey
                                        .currentState!
                                        .validate()) {
                                      cubit.saveCard();
                                    }
                                  },
                            color: cubit.isCardSaved
                                ? AppColors.lavender.withOpacity(0.5)
                                : AppColors.lavender,
                            child: TextCustom(
                                padding:
                                    EdgeInsets.only(left: 20.w, right: 10.w),
                                text: "Save Card",
                                color: Colors.white,
                                fontSize: 15.7,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
