import 'package:cloudwalk/utility/utility.dart';
import 'package:dio/dio.dart';

class NetworkClient {
  NetworkClient({required this.dio});

  final Dio dio;

  void setDioOptions(String token) {
    dio.options.contentType = Headers.jsonContentType;
    dio.options.headers['Authorization'] =
        (token.isEmpty) ? '' : 'Bearer $token';
  }

  Future<Response> get(
    String url,
    String? token, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    setDioOptions(token!);

    try {
      return await dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (error) {
      throw NetworkException(error);
    }
  }

  Future<Response> post(
    String url,
    String? token, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    setDioOptions(token!);

    try {
      return await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (error) {
      throw NetworkException(error);
    }
  }

  Future<Response> patch(
    String url,
    String? token, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    setDioOptions(token!);

    try {
      return await dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (error) {
      throw NetworkException(error);
    }
  }

  Future<Response> put(
    String url,
    String? token, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    setDioOptions(token!);

    try {
      return await dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (error) {
      throw NetworkException(error);
    }
  }
}
