import 'package:bot_toast/bot_toast.dart';
import 'package:cloudwalk/utility/utility.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoggingInterceptors extends Interceptor {
  int currentRequests = 0;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.extra['customProgress'] == false) {
      return super.onRequest(options, handler);
    }

    ++currentRequests;
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.extra['customProgress'] == false) {
      return super.onResponse(response, handler);
    }

    --currentRequests;
    if (0 >= currentRequests) {
      EasyLoading.dismiss();
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    BotToast.showText(
      text: NetworkException(err).getDetail(),
      contentColor: Colors.red,
    );

    --currentRequests;
    if (0 >= currentRequests) {
      EasyLoading.dismiss();
    }

    if (err.response!.extra['customProgress'] == false) {
      return super.onError(err, handler);
    }

    super.onError(err, handler);
  }
}
