import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:social_app/custom_widgets/custom_appbar.dart';
import 'package:social_app/custom_widgets/custom_button.dart';
import 'package:social_app/custom_widgets/custom_input.dart';
import 'package:social_app/data/client/api_client.dart';
import 'package:social_app/features/auth/sign_in/cubit/sign_in_cubit.dart';
import 'package:social_app/features/home/home_screen.dart';
import 'package:social_app/features/main/main_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool? isPhone;

  bool isValidEmail(String? value) => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ).hasMatch(value ?? '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocProvider(
          create: (context) => SignInCubit(userRepo: context.read()),
          child: Builder(builder: (context) {
            return BlocListener<SignInCubit, SignInState>(
              listener: (context, state) {
                if (state.status.isSuccess) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                  );
                } else if (state.status.isError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Не правильный логин или пароль'),
                    ),
                  );
                }
              },
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Log in',
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.w400),
                      ),
                    ),
                    const Gap(32),
                    CustomTextFormField(
                      hintText: 'jane@example.com',
                      unVisibly: true,
                      controller: loginTextController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Поле обязательно для заполнения';
                        }
                      },
                    ),
                    const Gap(16),
                    CustomTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Поле обязательно для заполнения';
                        }
                        return null;
                      },
                      unVisibly: false,
                      controller: passwordTextController,
                    ),
                    const Gap(16),
                    CustomButton(
                      buttonText: 'LOG IN',
                      textColor: Colors.white,
                      ontap: () {
                        final isValid = _formKey.currentState!.validate();
                        if (!isValid) return;
                        final passwordText = passwordTextController.text;
                        final loginText = loginTextController.text
                            .replaceAll(' ', '')
                            .replaceAll('+', '');
                        if (isValidEmail(loginText)) {
                          context
                              .read<SignInCubit>()
                              .signIn(loginText, passwordText);
                        } else {}
                      },
                      buttonColor: Colors.black,
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
