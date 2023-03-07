// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:social_app/data/model/post_model.dart';
// import 'package:social_app/features/home/widgets/image_card.dart';

// import '../../data/client/api_client.dart';
// import '../../data/repositories/post_repo.dart';
// import 'cubit/home_cubit.dart';
// import 'widgets/lenta_image_card.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({
//     Key? key,
//     required this.apiService,
//   }) : super(key: key);
//   final ApiService apiService;
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocProvider<PostFetchCubit>(
//         create: (context) => PostFetchCubit(
//           apiRepo: ApiRepo(
//             apiService: widget.apiService,
//           ),
//         )..fetchPostApi(),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(right: 16, left: 16, top: 70),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Discover',
//                   style: TextStyle(fontSize: 36, fontWeight: FontWeight.w400),
//                 ),
//                 const Gap(32),
//                 const Text(
//                   "WHAT'S NEW TODAY",
//                   style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),
//                 ),
//                 const Gap(24),
//                 BlocBuilder<PostFetchCubit, PostFetchState>(
//                   builder: (context, state) {
//                     if (state is PostFetchLoading) {
//                       return Center(child: CircularProgressIndicator());
//                     } else if (state is PostFetchError) {
//                       return Text(state.failure.message);
//                     } else if (state is PostFetchLoaded) {
//                       final postResult = state.postList;
//                       return postResult.isEmpty
//                           ? Center(child: Text('Empty post'))
//                           : Column(
//                               children: [
//                                 ImageCardItem(
//                                   posts: postResult,
//                                 ),
//                                 LentaImageCard(
//                                   posts: postResult,
//                                 ),
//                               ],
//                             );
//                     }
//                     return SizedBox.shrink();
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:social_app/data/model/post_model.dart';
import 'package:social_app/features/home/widgets/full_size_image.dart';
import 'package:social_app/features/home/widgets/image_card.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../custom_widgets/custom_avatar.dart';
import '../../data/client/api_client.dart';
import '../../data/repositories/post_repo.dart';
import 'cubit/home_cubit.dart';
import 'widgets/lenta_image_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final apiService = ApiService();

class _HomeScreenState extends State<HomeScreen> {
  late final postCubit = PostFetchCubit(
    apiRepo: ApiRepo(
      apiService: apiService,
    ),
  );

  final scrollController = ScrollController();

  final sscrollController = ScrollController();
  @override
  void initState() {
    setupScrollController();
    super.initState();
  }

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          postCubit.fetchPostApi();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return BlocProvider<PostFetchCubit>.value(
      value: postCubit..fetchPostApi(),
      child: Scaffold(
        body: SingleChildScrollView(
          controller: scrollController,
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
                BlocBuilder<PostFetchCubit, PostFetchState>(
                  builder: (context, state) {
                    if (state is PostsLoading && state.isFirstFetch) {
                      return Center(child: CircularProgressIndicator());
                    }
                    List<PostModel> posts = [];
                    bool isLoading = false;
                    if (state is PostsLoading) {
                      posts = state.oldPosts;
                      isLoading = true;
                    } else if (state is PostsLoaded) {
                      posts = state.posts;
                      return SizedBox(
                        width: width,
                        height: height * 0.4554,
                        child: ListView.separated(
                          controller: sscrollController,
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
                                            posts: posts,
                                          )));
                                },
                                child: SizedBox(
                                  height: 353,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                scrollController.jumpTo(
                                    scrollController.position.maxScrollExtent);
                              });
                              return CircularProgressIndicator();
                            }
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(),
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
                BlocBuilder<PostFetchCubit, PostFetchState>(
                  builder: (context, state) {
                    if (state is PostsLoading && state.isFirstFetch) {
                      return Center(child: CircularProgressIndicator());
                    }
                    List<PostModel> posts = [];
                    bool isLoading = false;
                    if (state is PostsLoading) {
                      posts = state.oldPosts;
                      isLoading = true;
                    } else if (state is PostsLoaded) {
                      posts = state.posts;
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: post.thumbnailUrl.toString(),
                                fit: BoxFit.cover,
                              ),
                            );
                          } else {
                            Timer(Duration(milliseconds: 30), () {
                              scrollController.jumpTo(
                                  scrollController.position.maxScrollExtent);
                            });

                            return CircularProgressIndicator();
                          }
                        },
                        staggeredTileBuilder: (index) {
                          return StaggeredTile.count(
                              1, index.isEven ? 1.2 : 1.8);
                        },
                        itemCount: posts.length + (isLoading == true ? 1 : 0),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
