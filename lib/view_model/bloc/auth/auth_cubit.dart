import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local/shared_prefrence/shared_keys.dart';
import '../../data/local/shared_prefrence/shared_prefrence.dart';
import '../../data/network/dio_helper.dart';
import '../../data/network/end_points.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobilePhoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool passwordVisible = true;
  bool conPasswordVisible = true;
  bool usingEmail = true;
  bool isTimerActive = false;
  int remainingTime = 30;

  void startTimer() {
    isTimerActive = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime == 0) {
        timer.cancel();
        isTimerActive = false;
        emit(EnableResendButtonState());
        return;
      }
      remainingTime--;
      emit(ChangeTimerState());
    });
  }

  void resetTimer() {
    remainingTime = 30;
    emit(ChangeTimerState());
  }

  void changePasswordVisibility() {
    passwordVisible = !passwordVisible;
    emit(ChangeVisibilityState());
  }

  void changeConPasswordVisibility() {
    conPasswordVisible = !conPasswordVisible;
    emit(ChangeVisibilityState());
  }

  void changeForgotPasswordMethod() {
    usingEmail = !usingEmail;
    emit(ChangeForgotPasswordMethodState());
  }

  void checkOtpLength(String otp) {
    if (otp.length == 4) {
      emit(EnableVerifyButtonState());
    } else {
      emit(DisableVerifyButtonState());
    }
  }

  Future<void> restController() async {
    userNameController.clear();
    emailController.clear();
    mobilePhoneController.clear();
    countryController.clear();
    birthDateController.clear();
    passwordController.clear();
  }

  String? loginError;

  Future<void> loginWithApi() async {
    emit(LoginLoadingState());
    await DioHelper.post(
      endpoint: EndPoints.login,
      body: {
        "email": emailController.text,
        "password": passwordController.text
      },
    ).then((value) {
      print(value?.data);
      saveDataToLocal(value?.data);
      emit(LoginSuccessState());
    }).catchError((error) {
      if (error is DioException) {
        if (error.response?.data.toString() == "password is Not Correct") {
          passwordError = "password is Not Correct";
        } else {
          loginError = error.response?.data.toString();
        }
      }
      emit(LoginErrorState());
      throw error;
    });
  }

  String? nameError;
  String? phoneError;
  String? passwordError;
  String? emailError;

  Future<void> registerWithApi() async {
    emit(RegisterLoadingState());
    await DioHelper.post(
      endpoint: EndPoints.register,
      body: {
        "username": userNameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "phonenumber": mobilePhoneController.text,
        "dateofbirth": birthDateController.text,
      },
    ).then((value) {
      print(value?.data);
      LocalData.set(key: SharedKeys.birthDate, value: birthDateController.text);
      saveDataToLocal(value?.data);
      emit(RegisterSuccessState());
    }).catchError((error) {
      if (error is DioException) {
        print(error.response?.data.toString());
        if (error.response?.data.toString() == "User Already Exists") {
          nameError = "User Already Exists";
          emailError = "User Already Exists";
        } else if (error.response?.data.toString() != "User Already Exists") {
          nameError = error.response?.data["errors"]["Username"].toString();
          phoneError =
              (error.response?.data["errors"]["phone"] as List<dynamic>?)
                  ?.first
                  ?.toString();
          passwordError =
              (error.response?.data["errors"]["Password"] as List<dynamic>?)
                  ?.first
                  ?.toString();
          emailError =
              (error.response?.data["errors"]["Email"] as List<dynamic>?)
                  ?.first
                  ?.toString();
        }
      }
      emit(RegisterErrorState());
      nameError = error.response?.data.toString();
      throw error;
    });
  }

  Future<void> verifyWithApi() async {
    emit(VerifyLoadingState());
    await DioHelper.post(
      endpoint: EndPoints.Verify,
      token: LocalData.get(SharedKeys.verificationCode),
    ).then((value) {
      print(value?.data);
      emit(VerifySuccessState());
    }).catchError((error) {
      if (error is DioException) {
        print(error.response?.data.toString());
      }
      emit(VerifyErrorState());
      throw error;
    });
  }

  Future<void> forgetPasswordWithApi() async {
    emit(ForgetPasswordLoadingState());
    await DioHelper.post(
      endpoint: EndPoints.ForgetPassword,
      prams: {"email": emailController.text},
    ).then((value) {
      print(value?.data);
      emit(ForgetPasswordSuccessState());
    }).catchError((error) {
      if (error is DioException) {
        print(error.response?.data.toString());
      }
      emit(ForgetPasswordErrorState());
      throw error;
    });
  }

  Future<void> resetPasswordWithApi() async {
    emit(ResetPasswordLoadingState());
    await DioHelper.post(
      endpoint: EndPoints.reset_Password,
      body: {
        "taken": LocalData.get(SharedKeys.token),
        "password": passwordController.text
      },
    ).then((value) {
      print(value?.data);
      emit(ResetPasswordSuccessState());
    }).catchError((error) {
      if (error is DioException) {
        print(error.response?.data.toString());
      }
      emit(ResetPasswordErrorState());
      throw error;
    });
  }

  Future<void> logoutWithApi() async {
    restController();
    LocalData.removeData(SharedKeys.isLogin);
    LocalData.removeData(SharedKeys.token);
    LocalData.removeData(SharedKeys.userName);
    emit(LogoutAndClearSuccessState());
  }

  void saveDataToLocal(Map<String, dynamic> value) {
    LocalData.set(key: SharedKeys.isLogin, value: true);
    LocalData.set(
        key: SharedKeys.userName, value: value['username'].toString());
    LocalData.set(key: SharedKeys.email, value: value['email'].toString());
    LocalData.set(key: SharedKeys.userId, value: value['id']);
    LocalData.set(
        key: SharedKeys.verificationCode,
        value: value['verificationToken'].toString());
  }

  int calculateAge(String dob) {
    List<String> parts = dob.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);

    DateTime birthDate = DateTime(year, month, day);

    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }
}
