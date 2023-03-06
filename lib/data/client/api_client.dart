import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  static const FETCH_LIMIT = 15;
  final baseUrl = 'https://jsonplaceholder.typicode.com/photos';
  Future<Response?> getPostData(int page) async {
    try {
      final Response? response =
          await _dio.get(baseUrl + '?_limit=$FETCH_LIMIT&_page=$page');
      print(response.toString());
      return response;
    } catch (err) {
      print("Error :$err");
    }
  }
}
