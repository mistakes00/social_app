import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:social_app/custom_widgets/custom_appbar.dart';
import 'package:social_app/custom_widgets/custom_avatar.dart';
import 'package:social_app/data/model/post_model.dart';
import 'package:social_app/features/home/widgets/image_card.dart';
import 'package:transparent_image/transparent_image.dart';

import 'widgets/lenta_image_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? data;

  List<PostModel> posts = [];

  String? error;
  bool isLoading = false;
  @override
  void initState() {
    getPosts();
    super.initState();
  }

  void getPosts() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final response =
          await Dio().get('https://jsonplaceholder.typicode.com/photos');
      if (response.statusCode == 200) {
        posts = List.from(response.data).map((e) {
          return PostModel(
            albumId: e['albumId'],
            id: e['id'],
            url: e['url'],
            thumbnailUrl: e['thumbnailUrl'],
          );
        }).toList();
      }
    } on DioError catch (e) {
      setState(() {
        error = 'Network error ${e.response?.statusCode}';
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, top: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Discover',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w400),
              ),
              const Gap(32),
              const Text(
                "WHAT'S NEW TODAY",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),
              ),
              const Gap(24),
              isLoading == false
                  ? ImageCardItem(
                      posts: posts,
                    )
                  : Center(child: CircularProgressIndicator.adaptive()),
              isLoading == false
                  ? LentaImageCard(
                      posts: posts,
                    )
                  : Center(child: CircularProgressIndicator.adaptive()),
            ],
          ),
        ),
      ),
    );
  }
}
