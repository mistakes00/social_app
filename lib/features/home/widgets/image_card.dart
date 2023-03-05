import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_app/data/model/post_model.dart';
import 'package:social_app/features/home/widgets/full_size_image.dart';

import '../../../custom_widgets/custom_avatar.dart';

class ImageCardItem extends StatelessWidget {
  ImageCardItem({Key? key, required this.posts}) : super(key: key);
  final List<PostModel> posts;
  // List<String> imageList = [
  //   'https://cdn.pixabay.com/photo/2019/03/15/09/49/girl-4056684_960_720.jpg',
  //   'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
  //   'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
  //   'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
  //   'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
  //   'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
  //   'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
  //   'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
  //   'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
  //   'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
  //   'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
  // ];
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
                        image: post.url,
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
          return SizedBox(width: 16);
        },
      ),
    );
  }
}