import 'package:flutter/material.dart';
import 'package:social_app/custom_widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'My profile screen',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
