import 'package:boilerplateflubloc/api/setup/baseApi.dart';
import 'package:flutter/cupertino.dart';

class UserApi extends BaseApi{
  @override
  // TODO: implement path
  get path => "/users";
  static UserApi _instance = UserApi();
  static UserApi get instance {
    if (_instance == null) _instance = UserApi();
    return _instance;
  }

  Future get() {
    return dio.get("$path");
  }

 Future getProducts(){
    debugPrint(path);
    return dio.get(path);
  }
  
}