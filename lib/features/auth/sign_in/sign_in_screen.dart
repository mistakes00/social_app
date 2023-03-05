import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:social_app/custom_widgets/app_icon.dart';
import 'package:social_app/custom_widgets/custom_appbar.dart';
import 'package:social_app/custom_widgets/custom_button.dart';
import 'package:social_app/custom_widgets/custom_input.dart';

import '../../../core/app_route.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Log in',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w400),
                ),
              ),
              const Gap(32),
              CustomTextFormField(
                hintText: 'jane@example.com',
                unVisibly: true,
                controller: loginTextController,
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
                ontap: () {},
                buttonColor: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
