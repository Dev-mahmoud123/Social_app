
abstract class LoginState {}

class LoginInitState extends LoginState {}

class LoginChangePasswordState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String uid;

  LoginSuccessState(this.uid);
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}
