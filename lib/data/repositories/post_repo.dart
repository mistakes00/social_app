import 'package:social_app/data/model/post_model.dart';

import '../client/api_client.dart';

abstract class PostRepo {
  Future<List<PostModel>?> getPostList(int page);
}

class ApiRepo implements PostRepo {
  const ApiRepo({
    required this.apiService,
  });
  final ApiService apiService;

  Future<List<PostModel>?> getPostList(int page) async {
    final response = await apiService.getPostData(page);
    if (response != null) {
      final data = response.data as List<dynamic>;
      return data.map((singlePost) => PostModel.fromMap(singlePost)).toList();
    }
  }
}
