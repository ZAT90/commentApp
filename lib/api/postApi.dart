
import 'package:flutter/cupertino.dart';

import 'setup/baseApi.dart';

class PostAPI extends BaseApi{
  @override
  // TODO: implement path
  get path => "/posts";
  static PostAPI _instance = PostAPI();
  static PostAPI get instance {
    if (_instance == null) _instance = PostAPI();
    return _instance;
  }

  // Future get() {
  //   return dio.get("$path");
  // }

  Future getPosts(){
    return dio.get(path);
  }

  
  
}