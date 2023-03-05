import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_app/custom_widgets/custom_appbar.dart';
import 'package:social_app/custom_widgets/custom_button.dart';

import '../../../custom_widgets/custom_input.dart';
import 'reg_second_screen.dart';

class SignUpFirstScreen extends StatefulWidget {
  SignUpFirstScreen({Key? key}) : super(key: key);

  @override
  State<SignUpFirstScreen> createState() => _SignUpFirstScreenState();
}

class _SignUpFirstScreenState extends State<SignUpFirstScreen> {
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Register',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w400),
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
                buttonText: 'NEXT',
                textColor: Colors.white,
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SignUpSecondScreen()));
                },
                buttonColor: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
