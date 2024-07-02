import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicare/view/components/customs/button_custom.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view/components/customs/textfeild_custom.dart';
import 'package:medicare/view/components/widgets/password_widget.dart';
import 'package:medicare/view_model/bloc/auth/auth_cubit.dart';
import 'package:medicare/view_model/data/local/shared_prefrence/shared_prefrence.dart';
import 'package:medicare/view_model/utils/app_colors.dart';

import '../../../../../view_model/data/local/shared_prefrence/shared_keys.dart';
import '../../../../../view_model/utils/routes.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    return Form(
      key: cubit.loginFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              labelName: "Email",
              controller: cubit.emailController,
              hintText: "example@gmail.com",
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Email can't be empty";
                }
                else if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return 'Enter a valid email address';
                } else if(cubit.loginError != null){
                  return cubit.loginError;
                }
                return null;
              },
            onTap: () {
                cubit.loginError = null;
            },
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r"\s")),
              FilteringTextInputFormatter.deny(RegExp(r"\n")),
              FilteringTextInputFormatter.deny(RegExp(r"\t")),
              FilteringTextInputFormatter.deny(RegExp(r"\r")),
              LengthLimitingTextInputFormatter(100),

            ],
              ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return PasswordWidget(cubit: cubit);
            },
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, NamedRoutes.forgetPassword);
              },
              child: const TextCustom(
                fontSize: 14,
                text: "Forgot Password?",
                color: AppColors.lavender,
                textAlign: TextAlign.right,
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(12),
          ),
          ButtonCustom(
            width: double.infinity,
            onPressed: () {
              if (cubit.loginFormKey.currentState!.validate()) {
                cubit.loginWithApi().then((value) {

                  Navigator.pushNamedAndRemoveUntil(context, NamedRoutes.home, (route) => false);
                  LocalData.set(key:SharedKeys.userId , value:1);
                });
              }
            },
            child: const TextCustom(
              text: "Log In",
              fontSize: 18,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
),
    );
  }
}
