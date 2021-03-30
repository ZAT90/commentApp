
import 'package:flutter/cupertino.dart';

import 'setup/baseApi.dart';

class CommentAPI extends BaseApi{
  @override
  // TODO: implement path
  get path => "/comments";
  static CommentAPI _instance = CommentAPI();
  static CommentAPI get instance {
    if (_instance == null) _instance = CommentAPI();
    return _instance;
  }

  // Future get() {
  //   return dio.get("$path");
  // }

  Future getComments(int postId){
    return dio.get('$path?postId=$postId');
  }

  
  
}