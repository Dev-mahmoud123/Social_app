import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user/user.dart';
import 'package:social_app/shared/bloc/state/register_state/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordState());
  }

  void userRegister({
    @required name,
    @required email,
    @required password,
    @required phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.email);
      print(value.user.uid);
      createUser(name: name, email: email, uid: value.user.uid, phone: phone);
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });
  }

  void createUser({
    @required name,
    @required email,
    @required uid,
    @required phone,
  }) {
    UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone,
        uid: uid,
        bio: 'write your bio...',
        isEmailVerified: false,
        cover:'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
        profileImage:'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toJson())
        .then((value) {
      emit(RegisterCreateUserSuccessState(uid));
    }).catchError((error) {
      emit(RegisterCreateUserErrorState(error));
    });
  }
}
