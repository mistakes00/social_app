import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_app/custom_widgets/custom_button.dart';
import 'package:social_app/features/auth/sign_in/sign_in_screen.dart';

import '../../custom_widgets/custom_avatar.dart';
import 'sign_up/reg_first_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/backroundimg.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 683,
                // height: double.infinity,
              ),
              Positioned(
                top: 300,
                left: 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 84),
                  child: Image.asset(
                    'assets/images/text_photo.png',
                  ),
                ),
              ),
              const Positioned(
                bottom: 20,
                left: 16,
                child: AvatarWidget(
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKpeDKUVlK_AzUItjz2AGCxLCRqIsSk-2iLw&usqp=CAU',
                  user: '@pawel_czerwinski',
                  nickName: 'Pawel Czerwinski',
                ),
              ),
            ],
          ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                    child: CustomButton(
                        buttonText: 'LOG IN',
                        ontap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SignIn()));
                        })),
                const Gap(9),
                Expanded(
                    child: CustomButton(
                  buttonText: 'REGISTER',
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUpFirstScreen()));
                  },
                  textColor: Colors.white,
                  buttonColor: Colors.black,
                )),
              ],
            ),
          ),
          const Gap(33),
        ],
      ),
    );
  }
}
