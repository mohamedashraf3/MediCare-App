import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicare/view/components/widgets/third_party_auth_widget/third_party_authentication.dart';
import 'package:medicare/view_model/bloc/auth/auth_cubit.dart';
import 'package:medicare/view_model/utils/routes.dart';

class ThirdPartyAuthenticationLogin extends StatelessWidget {
  const ThirdPartyAuthenticationLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ThirdPartyAuthWidget(
            operation: "Login",
            onFooterButtonPressed: () {
              AuthCubit.get(context).restController();
              Navigator.pushReplacementNamed(context, NamedRoutes.signup);
            },
            footerText: "Don't have an account?",
            footerButtonText: "Sign Up",
            onFaceTap: () {},
            onGoogleTap: () {
            },
            onAppleTap: () {});
      },
    );
  }
}
