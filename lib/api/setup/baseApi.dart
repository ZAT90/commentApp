import 'dart:developer';

import 'package:boilerplateflubloc/api/setup/appInterceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class BaseApi {
  static Dio _dio = initDio();
  static Dio initDio() {
    Dio dio = new Dio();
    dio.interceptors.addAll([
      AppInterceptors(),
      LogInterceptor(
          responseBody: kDebugMode,
          requestBody: kDebugMode,
          logPrint: (s) => log(s, name: "DIO")),
    ]);
    dio.options.baseUrl = "http://18.191.185.178/api";

    return dio;
  }

   Dio get dio {
    return _dio;
  }

  get path;
}
