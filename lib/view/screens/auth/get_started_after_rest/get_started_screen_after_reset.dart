import 'package:flutter/material.dart';
import 'package:medicare/view/components/widgets/after_verify_screen/after_verify_screen.dart';
import 'package:medicare/view/screens/home/home.dart';
import 'package:medicare/view_model/utils/images.dart';


class GetStartedScreenAfterReset extends StatelessWidget {
  const GetStartedScreenAfterReset({super.key});

  @override
  Widget build(BuildContext context) {
    return SuccessScreen(
        imagePath: Images.getStarted,
        title: "Successful Password Reset!",
        message: "You Can Now Use Your New Password to Log in to Your Account",
        goToScreen: HomeScreen());
  }
}
