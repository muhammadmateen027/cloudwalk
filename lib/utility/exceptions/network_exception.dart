import 'package:dio/dio.dart';

class NetworkException implements Exception {
  const NetworkException(DioError this.error);

  final DioError? error;
  final String defaultErrorDetail = 'Something went wrong. Please try again.';

  String getDetail() {
    var detail = defaultErrorDetail;


    return detail;
  }

  @override
  String toString() => getDetail();
}