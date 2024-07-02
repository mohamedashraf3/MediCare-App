import 'package:flutter/material.dart';
import 'package:medicare/view/screens/health_follow-up/health_condition/health%20_condition_screen.dart';

import '../../../../view_model/utils/images.dart';
import '../../../components/widgets/after_verify_screen/after_verify_screen.dart';

class GetStartedAfterSignup extends StatelessWidget {
  const GetStartedAfterSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return SuccessScreen(
        imagePath:Images.ex,
        title: "Excellent !",
        message:
            "The verification code was successful you’re now signed up and ready to go ",
        goToScreen: HealthConditionScreen());
  }
}
