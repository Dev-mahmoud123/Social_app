
abstract class RegisterState {}

class RegisterInitState extends RegisterState{}

class RegisterChangePasswordState extends RegisterState{}
class RegisterLoadingState extends RegisterState{}
class RegisterSuccessState extends RegisterState{}
class RegisterErrorState extends RegisterState{
  final String error;
  RegisterErrorState(this.error);
}
class RegisterCreateUserState extends RegisterState{}
class RegisterCreateUserSuccessState extends RegisterState{
  final String uid;

  RegisterCreateUserSuccessState(this.uid);
}
class RegisterCreateUserErrorState extends RegisterState{
  final String error;
  RegisterCreateUserErrorState(this.error);
}

