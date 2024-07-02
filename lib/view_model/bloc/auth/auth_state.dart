part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class ChangeVisibilityState extends AuthState {}

final class ChangeForgotPasswordMethodState extends AuthState {}

final class EnableVerifyButtonState extends AuthState {}

final class DisableVerifyButtonState extends AuthState {}

final class EnableResendButtonState extends AuthState {}

final class ChangeTimerState extends AuthState {}

final class RegisterLoadingState extends AuthState {}

final class RegisterSuccessState extends AuthState {}

final class RegisterErrorState extends AuthState {}

final class LoginLoadingState extends AuthState {}

final class LoginSuccessState extends AuthState {}

final class LoginErrorState extends AuthState {}

final class LogoutLoadingState extends AuthState {}

final class LogoutAndClearSuccessState extends AuthState {}
final class VerifyLoadingState extends AuthState {}
final class VerifySuccessState extends AuthState {}
final class VerifyErrorState extends AuthState {}
final class ForgetPasswordLoadingState extends AuthState {}
final class ForgetPasswordSuccessState extends AuthState {}
final class ForgetPasswordErrorState extends AuthState {}
final class ResetPasswordLoadingState extends AuthState {}
final class ResetPasswordSuccessState extends AuthState {}
final class ResetPasswordErrorState extends AuthState {}
