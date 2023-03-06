import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_app/data/model/post_model.dart';
import 'package:social_app/features/home/widgets/full_size_image.dart';

import '../../../custom_widgets/custom_avatar.dart';

class ImageCardItem extends StatelessWidget {
  const ImageCardItem({Key? key, required this.posts}) : super(key: key);
  final List<PostModel> posts;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: height * 0.4554,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (contect) => FullSizeImage(
                        posts: posts,
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
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 16);
        },
      ),
    );
  }
}
