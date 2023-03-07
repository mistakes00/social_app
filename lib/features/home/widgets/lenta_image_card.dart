import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_app/data/model/post_model.dart';
import 'package:transparent_image/transparent_image.dart';

class LentaImageCard extends StatelessWidget {
  const LentaImageCard(
      {Key? key,
      required this.posts,
      required this.controller,
      required this.isLoading})
      : super(key: key);
  final List<PostModel> posts;
  final ScrollController controller;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 12,
      itemBuilder: (context, index) {
        final post = posts[index];
        if (index < posts.length) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: post.thumbnailUrl.toString(),
              fit: BoxFit.cover,
            ),
          );
        } else {
          Timer(Duration(milliseconds: 500), () {
            controller.jumpTo(controller.position.maxScrollExtent);
          });

          return CircularProgressIndicator();
        }
      },
      staggeredTileBuilder: (index) {
        return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
      },
      itemCount: posts.length + (isLoading == true ? 1 : 0),
    );
  }
}
