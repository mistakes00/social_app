import '../../core/api_response.dart';

abstract class AuthRepo {
  Future<ApiResponse> login(String login, String password);
}

class AuthFakeRepo implements AuthRepo {
  @override
  Future<ApiResponse> login(String login, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (login == "admin@gmail.com" && password == "admin") {
      return ApiResponse(
        statusCode: 200,
      );
    }

    return ApiResponse(
      statusCode: 400,
      errorData: {'message': 'Неверный логин или пароль'},
    );
  }
}
