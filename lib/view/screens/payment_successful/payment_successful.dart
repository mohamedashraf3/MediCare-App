import 'package:flutter/material.dart';
import 'package:medicare/view/components/widgets/after_verify_screen/after_verify_screen.dart';
import 'package:medicare/view/screens/home/home.dart';
import 'package:medicare/view_model/utils/images.dart';

class PaymentSuccessfulScreen extends StatelessWidget {
  final String? title;
  final String? message;
  const PaymentSuccessfulScreen({super.key, this.title, this.message});

  @override
  Widget build(BuildContext context) {
    return SuccessScreen(
        imagePath: Images.getStarted,
        title:title ?? "Payment successful !",
        message: message ?? "Your payment is complete we’re getting your order",
        textButton: "Back to home page",
        goToScreen: HomeScreen());
  }
}
