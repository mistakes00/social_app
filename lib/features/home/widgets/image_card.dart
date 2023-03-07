import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_app/data/model/post_model.dart';
import 'package:social_app/features/home/widgets/full_size_image.dart';

import '../../../custom_widgets/custom_avatar.dart';

class ImageCardItem extends StatelessWidget {
  const ImageCardItem({
    Key? key,
    required this.posts,
    required this.controller,
    required this.isLoading,
  }) : super(key: key);
  final List<PostModel> posts;
  final ScrollController controller;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: height * 0.4554,
      child: ListView.separated(
        controller: controller,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: posts.length + (isLoading == true ? 1 : 0),
        itemBuilder: (context, index) {
          final post = posts[index];

          if (index < posts.length) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (contect) => FullSizeImage(
                          image: post.thumbnailUrl.toString(),
                          user: post.id.toString(),
                          nickName: post.title.toString(),
                        )));
              },
              child: SizedBox(
                height: 353,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 310,
                      width: 380,
                      child: Image.network(
                        post.url.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(16),
                    AvatarWidget(
                        imageUrl: post.thumbnailUrl,
                        user: post.id.toString(),
                        nickName: post.title),
                  ],
                ),
              ),
            );
          } else {
            Timer(Duration(milliseconds: 30), () {
              controller.jumpTo(controller.position.maxScrollExtent);
            });
            return CircularProgressIndicator();
          }
        },
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(width: 16),
      ),
    );
  }
}
