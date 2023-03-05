import 'package:social_app/core/api_response.dart';
import 'package:social_app/data/client/api_client.dart';
import 'package:social_app/data/model/paginated.dart';

import '../model/post_model.dart';

abstract class DiscoverRepo {
  Future<ApiResponse<Paginated<List<PostModel>>>> fetPostList({
    int? id,
    int? page,
  });
}

class DiscoverAPIRepo implements DiscoverRepo {
  const DiscoverAPIRepo(this._client);
  final ApiClient _client;

  @override
  Future<ApiResponse<Paginated<List<PostModel>>>> fetPostList({
    int? id,
    int? page,
  }) {
    return _client.get('https://jsonplaceholder.typicode.com/photos',
        params: {
          if (page != null) 'page': page,
        },
        decoder: (data) => Paginated.fromJson(
              json: data,
              data: List.from(data['result'].map((e) => PostModel.fromJson(e))),
            ));
  }
}
