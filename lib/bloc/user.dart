import 'package:boilerplateflubloc/api/user.dart';
import 'package:boilerplateflubloc/model/users.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum EventStatus { getUsers, updateUsers }

class UserEvents {
  final int value;
  final EventStatus status;

  const UserEvents({this.value, @required this.status});
}

class UserBloc extends Bloc<UserEvents, Users> {
  UserBloc() : super(Users());
  UserApi userApi = UserApi();
  @override
  Stream<Users> mapEventToState(UserEvents event) async* {
    switch (event.status) {
      case EventStatus.getUsers:
        Response response = await userApi.getProducts();
        Users users = Users.fromJson(response.data);
        yield users;
        break;
      case EventStatus.updateUsers:
        debugPrint('this is the postuser event: ${event.value}');
        break;
      default:
        addError(Exception('unsupported event'));
    }
  }
}
