import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_app/custom_widgets/custom_appbar.dart';
import 'package:social_app/custom_widgets/custom_button.dart';
import 'package:social_app/features/main/main_screen.dart';

import '../../../custom_widgets/custom_input.dart';

class SignUpSecondScreen extends StatefulWidget {
  const SignUpSecondScreen({Key? key}) : super(key: key);

  @override
  State<SignUpSecondScreen> createState() => _SignUpSecondScreenState();
}

class _SignUpSecondScreenState extends State<SignUpSecondScreen> {
  final nameTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                hintText: 'the_jane',
                unVisibly: true,
                controller: nameTextController,
              ),
              const Gap(16),
              CustomButton(
                buttonText: 'SIGN UP',
                textColor: Colors.white,
                ontap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const MainScreen()));
                },
                buttonColor: Colors.black,
              ),
              const Gap(32),
              RichText(
                text: TextSpan(
                  text: 'By signing up, you agree to Photo’s ',
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                        text: 'Terms of Service',
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        )),
                    const TextSpan(text: ' and'),
                    TextSpan(
                        text: ' Privacy Policy.',
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
