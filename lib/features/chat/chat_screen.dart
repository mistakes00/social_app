import 'package:flutter/material.dart';
import 'package:social_app/custom_widgets/custom_appbar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        implyLeading: false,
        title: 'Chat',
      ),
      body: Column(
        children: [
          Text(
            'Chat Screen!',
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
