part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

// ! Login STATES

class AuthLoginLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final String? message;
  AuthLoginSuccess(this.message);
}

class AuthLoginFailuer extends AuthState {
  final String message;
  AuthLoginFailuer(this.message);
}
// ! Register STATES

class AuthRegisterLoading extends AuthState {}

class AuthRegisterSuccess extends AuthState {
  final String message;
  AuthRegisterSuccess(this.message);
}

class AuthRegisterFailuer extends AuthState {
  final String message;
  AuthRegisterFailuer(this.message);
}
// ! Verify Code STATES

class AuthVerifyLoading extends AuthState {}

class AuthVerifySuccess extends AuthState {
  final String message;
  AuthVerifySuccess(this.message);
}

class AuthVerifyFailuer extends AuthState {
  final String message;
  AuthVerifyFailuer(this.message);
}

// ! Forget Password STATES

class AuthForgetPassLoading extends AuthState {}

class AuthForgetPassSuccess extends AuthState {
  final String message;
  AuthForgetPassSuccess(this.message);
}

class AuthForgetPassFailuer extends AuthState {
  final String message;
  AuthForgetPassFailuer(this.message);
}

// ! Reset Password STATES
class AuthResetPassLoading extends AuthState {}

class AuthResetPassSuccess extends AuthState {
  final String message;
  AuthResetPassSuccess(this.message);
}

class AuthResetPassFailuer extends AuthState {
  final String message;
  AuthResetPassFailuer(this.message);
}

// ! Change Password STATES
class AuthChangePassLoading extends AuthState {}

class AuthChangePassSuccess extends AuthState {
  final String message;
  AuthChangePassSuccess(this.message);
}

class AuthChangePassFailuer extends AuthState {
  final String message;
  AuthChangePassFailuer(this.message);
}

// ! Update Profile STATES
class AuthUpdateProfileLoading extends AuthState {}

class AuthUpdateProfileSuccess extends AuthState {
  final String message;
  AuthUpdateProfileSuccess(this.message);
}

class AuthUpdateProfileFailuer extends AuthState {
  final String message;
  AuthUpdateProfileFailuer(this.message);
}

// ! Update Profile Image STATES
class AuthUpdateProfileImageLoading extends AuthState {}

class AuthUpdateProfileImageSuccess extends AuthState {
  final String message;
  AuthUpdateProfileImageSuccess(this.message);
}

class AuthUpdateProfileImageFailuer extends AuthState {
  final String message;
  AuthUpdateProfileImageFailuer(this.message);
}
