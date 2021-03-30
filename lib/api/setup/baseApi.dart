import 'dart:developer';


import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'appInterceptor.dart';

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
    dio.options.baseUrl = "https://jsonplaceholder.typicode.com";

    return dio;
  }

   Dio get dio {
    return _dio;
  }

  get path;
}
