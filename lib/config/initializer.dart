import 'dart:developer';

import 'package:cloudwalk/service/service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cloudwalk/repository/repository.dart';
import 'package:get_it/get_it.dart';
import 'app_bloc_observer.dart';

GetIt locator = GetIt.instance;

class Initialization {
  // check either it's debug or release mode
  static const bool enableLogging = !kDebugMode;

  static init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Load environment file
    await dotenv.load(fileName: ".env");

    // Initialize EasyLoading
    _configEasyLoading();

    final _dio = Dio();
    // enable logs and bloc observer in staging and development
    if (kDebugMode) {
      Bloc.observer = AppBlocObserver();
      FlutterError.onError = (details) {
        log(details.exceptionAsString(), stackTrace: details.stack);
      };

      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
      _dio.interceptors.add(LoggingInterceptors());
    }

    // dependency injection for your repository
    locator.registerLazySingleton<ApiService>(
      () => ApiRepository(client: NetworkClient(dio: _dio)),
    );

    // dependency injection for your repository
    locator.registerLazySingleton<LocationInterface>(() => CurrentLocation());
  }

  static void _configEasyLoading() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.black.withOpacity(0.5)
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.red.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false
      ..toastPosition = EasyLoadingToastPosition.bottom;
  }
}
