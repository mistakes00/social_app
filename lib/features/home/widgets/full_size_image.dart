import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/custom_widgets/app_icon.dart';
import 'package:social_app/custom_widgets/custom_avatar.dart';

class FullSizeImage extends StatelessWidget {
  const FullSizeImage({Key? key, this.image}) : super(key: key);
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.network(
            image.toString(),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
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
        const Positioned(
          top: 46,
          left: 16,
          child: AvatarWidget(
            imageUrl: '',
            user: '@json',
            nickName: 'userName',
            textColor: Colors.white,
          ),
        ),
        Positioned(
          top: 46,
          right: 16,
          child: IconButton(
            icon: AppIcon(
              AppIcons.cancel,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
          ),
        )
      ]),
    );
  }
}
