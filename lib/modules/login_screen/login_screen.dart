import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/resuable_components.dart';
import 'package:social_app/layouts/social_layout.dart';
import 'package:social_app/modules/register_screen/register_screen.dart';
import 'package:social_app/shared/bloc/cubit/login_cubit/login_cubit.dart';
import 'package:social_app/shared/bloc/state/login_state/login_state.dart';
import 'package:social_app/shared/network/local/catch_data.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (BuildContext context, state) {
          if (state is LoginSuccessState) {
            CatchHelper.sharedPreferences
                .setString('uid', state.uid)
                .then((value) {
              print(state.uid.toString());
              navigateAndFinish(context: context, widget: SocialLayout());
            });
          } else if (state is LoginErrorState)
            defaultToast(message: state.error, state: ToastState.Error);
        },
        builder: (BuildContext context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: keyForm,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Login to communicate with your friends ',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    fontSize: 18.0, color: Colors.black54)),
                        SizedBox(
                          height: 40.0,
                        ),
                        defaultTextField(
                          label: 'Email',
                          prefixIcon: Icon(Icons.mail),
                          type: TextInputType.emailAddress,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Email must not be empty';
                            }
                            return null;
                          },
                          controller: emailController,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextField(
                          label: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          type: TextInputType.visiblePassword,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Password must not be empty';
                            }
                            return null;
                          },
                          controller: passwordController,
                          suffixIcon: InkWell(
                            child: Icon(cubit.suffix),
                            onTap: () {
                              cubit.changePasswordVisibility();
                            },
                          ),
                          isObscure: cubit.isPassword,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        state is! LoginLoadingState
                            ? Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue,
                                ),
                                child: defaultTextButton(
                                    press: () {
                                      if (keyForm.currentState.validate()) {
                                        cubit.userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                    text: 'Login',
                                    color: Colors.white),
                              )
                            : Center(child: CircularProgressIndicator()),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(' Don\'t have an account'),
                            defaultTextButton(
                                press: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                                },
                                text: 'Register'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
