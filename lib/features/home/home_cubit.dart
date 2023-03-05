// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:social_app/data/repositories/discover_repo.dart';

// import '../../core/loadable_resource.dart';
// import '../../data/model/post_model.dart';

// part 'post_cubit.freezed.dart';

// class PostCubit extends Cubit<PostState> {
//   PostCubit({
//     required DiscoverRepo postRepo,
//     PostModel? postDetails,
//   })  : _postRepo = postRepo,
//         super(const PostState());

//   final DiscoverRepo _postRepo;

//   Future<void> fetchPostList() async {
//     emit(state.copyWith(postList: state.postList.loading()));

//     final response = await _postRepo.fetPostList();
//     response.when(
//       success: (result) => emit(state.copyWith(
//         postList: state.postList.withData(result!),
//       )),
//       error: (message, errorData) => emit(state.copyWith(
//         postList: state.postList.withError(errorData.toString()),
//       )),
//     );
//   }
// }

// @freezed
// class PostState with _$PostState {
//   const factory PostState({
//     @Default(LoadableResource(data: null))
//         final LoadableResource<List<PostModel>?> postList,
//   }) = _PostState;
// }
