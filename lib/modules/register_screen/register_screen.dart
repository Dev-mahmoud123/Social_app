import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/resuable_components.dart';
import 'package:social_app/layouts/social_layout.dart';
import 'package:social_app/modules/login_screen/login_screen.dart';
import 'package:social_app/shared/bloc/cubit/register_cubit/register_cubit.dart';
import 'package:social_app/shared/bloc/state/register_state/register_state.dart';
import 'package:social_app/shared/network/local/catch_data.dart';

class RegisterScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (BuildContext context, state) {
          if (state is RegisterCreateUserSuccessState) {
            CatchHelper.sharedPreferences
                .setString('uid', state.uid)
                .then((value) {
              print(state.uid.toString());
              navigateAndFinish(context: context, widget: SocialLayout());
            });
          }
        },
        builder: (BuildContext context, state) {
          final RegisterCubit cubit = RegisterCubit.get(context);
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
                        Text('Register to communicate with your friends ',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    fontSize: 18.0, color: Colors.black54)),
                        SizedBox(
                          height: 40.0,
                        ),
                        defaultTextField(
                          label: 'name',
                          prefixIcon: Icon(Icons.person),
                          type: TextInputType.text,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Name must not be empty';
                            }
                            return null;
                          },
                          controller: nameController,
                        ),
                        SizedBox(
                          height: 15.0,
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
                          label: 'phone',
                          prefixIcon: Icon(Icons.phone),
                          type: TextInputType.phone,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Phone must not be empty';
                            }
                            return null;
                          },
                          controller: phoneController,
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
                        state is! RegisterLoadingState
                            ? Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue,
                                ),
                                child: defaultTextButton(
                                  press: () {
                                    if (keyForm.currentState.validate()) {
                                      cubit.userRegister(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text);
                                    }
                                  },
                                  text: 'Register',
                                  color: Colors.white,
                                ),
                              )
                            : Center(child: CircularProgressIndicator()),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(' Already have an account'),
                            defaultTextButton(
                                press: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                  );
                                },
                                text: 'Login'),
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
