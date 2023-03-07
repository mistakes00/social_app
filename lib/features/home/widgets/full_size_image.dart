import 'package:flutter/material.dart';
import 'package:social_app/custom_widgets/app_icon.dart';
import 'package:social_app/custom_widgets/custom_avatar.dart';

import '../../../data/model/post_model.dart';

class FullSizeImage extends StatelessWidget {
  const FullSizeImage(
      {Key? key,
      required this.image,
      required this.user,
      required this.nickName})
      : super(key: key);

  final String image;
  final String user;
  final String nickName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return Stack(children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(0, 0, 0, 1),
                  Color.fromRGBO(196, 196, 196, 0),
                ],
              ),
            ),
            height: 200,
          )),
          Positioned(
            top: 46,
            left: 16,
            child: AvatarWidget(
              imageUrl: image,
              user: user,
              nickName: nickName,
              textColor: Colors.white,
            ),
          ),
          Positioned(
            top: 46,
            right: 16,
            child: IconButton(
              icon: const AppIcon(
                AppIcons.cancel,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white,
            ),
          )
        ]);
      }),
    );
  }
}
