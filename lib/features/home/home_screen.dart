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

  final verScrollController = ScrollController();

  final horScrollController = ScrollController();
  @override
  void initState() {
    setupScrollController();
    super.initState();
  }

  void setupScrollController() {
    verScrollController.addListener(() {
      if (verScrollController.position.atEdge) {
        if (verScrollController.position.pixels != 0) {
          postCubit.fetchPostApi();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostFetchCubit>.value(
      value: postCubit..fetchPostApi(),
      child: Scaffold(
        body: SingleChildScrollView(
          controller: verScrollController,
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
                      return ImageCardItem(
                        posts: posts,
                        controller: horScrollController,
                        isLoading: isLoading,
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
                      return LentaImageCard(
                        posts: posts,
                        controller: verScrollController,
                        isLoading: isLoading,
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
