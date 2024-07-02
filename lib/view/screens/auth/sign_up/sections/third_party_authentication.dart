import 'package:flutter/material.dart';
import 'package:medicare/view/components/widgets/third_party_auth_widget/third_party_authentication.dart';
import 'package:medicare/view_model/bloc/auth/auth_cubit.dart';

import '../../../../../view_model/utils/routes.dart';

class ThirdPartyAuthenticationSingUp extends StatelessWidget {
  const ThirdPartyAuthenticationSingUp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThirdPartyAuthWidget(
      operation: "Sign Up",
      footerButtonText: "Log In",
      onFooterButtonPressed: () {
        AuthCubit.get(context).restController();
        Navigator.pushReplacementNamed(context, NamedRoutes.login);
      },
      footerText: "Already have an account?",
      onFaceTap: () {},
      onGoogleTap: () {
      },
      onAppleTap: () {},
    );
  }
}
