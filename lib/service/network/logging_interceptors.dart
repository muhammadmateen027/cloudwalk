import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoggingInterceptors extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.extra['customProgress'] == false) {
      return super.onRequest(options, handler);
    }

    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.extra['customProgress'] == false) {
      return super.onResponse(response, handler);
    }

    EasyLoading.dismiss();
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    EasyLoading.dismiss();

    if (err.response!.extra['customProgress'] == false) {
      return super.onError(err, handler);
    }

    super.onError(err, handler);
  }
}
