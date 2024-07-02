import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:medicare/view/components/customs/button_custom.dart';
import 'package:medicare/view/components/customs/text_custom.dart';
import 'package:medicare/view/components/customs/textfeild_custom.dart';
import 'package:medicare/view/components/widgets/password_widget.dart';
import 'package:medicare/view/components/widgets/phone_widget.dart';
import 'package:medicare/view/screens/auth/get_started_after_signup/get_started_after_signup.dart';
import 'package:medicare/view/screens/auth/verification/verification_screen.dart';
import 'package:medicare/view_model/bloc/auth/auth_cubit.dart';
import 'package:medicare/view_model/utils/app_colors.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final RegExp nameExp =
        RegExp(r"([a-zA-Z]{2,}\s[a-zA-Z]{2,}(?:\s[a-zA-Z]{2,})*)");
    var cubit = AuthCubit.get(context);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Form(
          key: cubit.signUpFormKey,
          child: Column(
            children: [
              CustomTextField(
                labelName: "Username",
                controller: cubit.userNameController,
                hintText: "Your name",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Username can't be empty";
                  } else if (!nameExp.hasMatch(value)) {
                    return 'Enter a valid full name (e.g., John Doe)';
                  } else if (cubit.nameError != null) {
                    return cubit.nameError;
                  }
                  return null;
                },
                onTap: () {
                  cubit.nameError = null;
                },
              ),
              SizedBox(height: ScreenUtil().setHeight(4)),
              CustomTextField(
                labelName: "Email",
                controller: cubit.emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: "example@gmail.com",
                textInputAction: TextInputAction.next,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email can't be empty";
                  } else if (!(value.contains("@") && value.contains("."))) {
                    return "Enter a valid email";
                  } else if (cubit.emailError != null) {
                    return cubit.emailError;
                  }
                  return null;
                },
                onTap: () {
                  cubit.emailError = null;
                },
              ),
              SizedBox(height: ScreenUtil().setHeight(4)),
              PasswordWidget(cubit: cubit),
              SizedBox(height: ScreenUtil().setHeight(4)),
              PhoneWidget(cubit: cubit),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              CustomTextField(
                labelName: 'Birth Date',
                hintText: 'yyyy-mm-dd',
                readOnly: true,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.none,
                controller: cubit.birthDateController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Birth Date can't be empty";
                  }
                  return null;
                },
                onTap: () {
                  showDatePicker(
                    keyboardType: TextInputType.none,
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                    helpText: 'Select Your Birth Date',
                    context: context,
                    initialDate: DateTime(2000, 1, 1),
                    firstDate: DateTime(1900, 1, 1),
                    lastDate: DateTime(DateTime.now().year, 12, 1),
                  ).then((value) {
                    if (value != null) {
                      cubit.birthDateController.text =
                          DateFormat('yyyy-MM-dd').format(value);
                    }
                  });
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              ButtonCustom(
                width: double.infinity,
                onPressed: () {
                  if (cubit.signUpFormKey.currentState!.validate()) {
                    cubit.registerWithApi().then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        cubit.otpController.clear();
                        return VerificationScreen(
                          nameScreen: GetStartedAfterSignup(),
                          verify: () {
                            return cubit.verifyWithApi();
                          },
                        );
                      }));
                    });
                  }
                },
                child: const TextCustom(
                  text: "Sign Up",
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
