import 'package:flutter/material.dart';

class AddingScreen extends StatelessWidget {
  const AddingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Text(
            'Here you can add a new images',
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
