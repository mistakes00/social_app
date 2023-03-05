import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../core/api_response.dart';
import '../storage/local_storage.dart';

class ApiClient {
  final Dio _dio;
  final Logger _logger;

  ApiClient._(this._dio) : _logger = Logger('ApiClient');

  factory ApiClient({
    required LocalStorage storage,
  }) {
    final dio = Dio(BaseOptions());
    // dio.interceptors.add(
    //   DioCacheManager(CacheConfig(
    //     defaultMaxAge: const Duration(days: 7),
    //     baseUrl: baseUrl,
    //   )).interceptor,
    // );

    return ApiClient._(dio);
  }

  Future<ApiResponse<T>> get<T>(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    required T Function(dynamic data) decoder,
  }) {
    return request<T>(
      url,
      'get',
      decoder: decoder,
      params: params,
      options: options,
    );
  }

  Future<ApiResponse<T>> post<T>(
    String url, {
    T Function(dynamic data)? decoder,
    dynamic data,
  }) {
    return request<T>(
      url,
      'POST',
      decoder: decoder,
      data: data,
    );
  }

  Future<ApiResponse<T>> put<T>(
    String url, {
    T Function(dynamic data)? decoder,
    dynamic data,
  }) {
    return request<T>(
      url,
      'PUT',
      decoder: decoder,
      data: data,
    );
  }

  Future<ApiResponse<T>> patch<T>(
    String url, {
    T Function(dynamic data)? decoder,
    dynamic data,
  }) {
    return request<T>(
      url,
      'PATCH',
      decoder: decoder,
      data: data,
    );
  }

  Future<ApiResponse<T>> delete<T>(
    String url, {
    T Function(dynamic data)? decoder,
    dynamic params,
  }) {
    return request<T>(
      url,
      'DELETE',
      decoder: decoder,
      params: params,
    );
  }

  Future<ApiResponse<T>> request<T>(
    String url,
    String method, {
    required T Function(dynamic data)? decoder,
    Map<String, dynamic>? params,
    dynamic data,
    Options? options,
  }) async {
    final model = ApiResponse<T>();
    try {
      final response = await _dio.request(
        url,
        queryParameters: params,
        data: data,
        options: (options ?? Options()).copyWith(method: method),
      );
      _logger.info(
        'request $url \nstatus-code:${response.statusCode};',
      );
      model.statusCode = response.statusCode;
      model.result = decoder?.call(response.data);
    } on DioError catch (e) {
      model.statusCode = e.response?.statusCode;
      model.errorData = e.response?.data;
      _logger.warning('----------------------------');
      _logger.warning('request error: ');
      // _logger.warning(e.response?.data);
      _logger.warning('$url $e');
      if (method != 'GET') _logger.warning('params $data');
      _logger.warning('----------------------------');
    }

    return model;
  }
}
