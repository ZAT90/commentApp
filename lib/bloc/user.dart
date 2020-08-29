import 'package:boilerplateflubloc/api/user.dart';
import 'package:boilerplateflubloc/model/users.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum UserEvents { getUsers, updateUsers }

class UserBloc extends Bloc<UserEvents, Users> {
  UserBloc() : super(Users());
  UserApi userApi = UserApi();
  @override
  Stream<Users> mapEventToState(UserEvents event) async* {
    switch (event) {
      case UserEvents.getUsers:
        debugPrint('this is the getuser event');
        //Users users = await userApi.getProducts();
        Response response = await userApi.getProducts();
        Users users = Users.fromJson(response.data);
        yield users;
        break;
      case UserEvents.updateUsers:
        debugPrint('this is the postuser event');
        break;
      default:
        addError(Exception('unsupported event'));
    }
  }
}
