import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/data/model/post_model.dart';

import '../../../data/repositories/post_repo.dart';

class PostFetchCubit extends Cubit<PostFetchState> {
  final ApiRepo apiRepo;
  int page = 1;
  PostFetchCubit({required this.apiRepo}) : super(PostFetchInitial());
  void fetchPostApi() {
    if (state is PostsLoading) return;

    final currentState = state;

    var oldPosts = <PostModel>[];
    if (currentState is PostsLoaded) {
      oldPosts = currentState.posts;
    }

    emit(PostsLoading(oldPosts, isFirstFetch: page == 1));

    apiRepo.getPostList(page).then((newPosts) {
      page++;

      final posts = (state as PostsLoading).oldPosts;
      posts.addAll(newPosts ?? []);

      emit(PostsLoaded(posts));
    });
  }
}

@immutable
abstract class PostFetchState {}

class PostsInitial extends PostFetchState {}

class PostsLoaded extends PostFetchState {
  final List<PostModel> posts;

  PostsLoaded(this.posts);
}

class PostsLoading extends PostFetchState {
  final List<PostModel> oldPosts;
  final bool isFirstFetch;

  PostsLoading(this.oldPosts, {this.isFirstFetch = false});
}

class PostFetchInitial extends PostFetchState {}
