import 'package:equatable/equatable.dart';

class Posts extends Equatable{
  int userId;
  int id;
  String title;
  String body;

  Posts({this.userId, this.id, this.title, this.body});

  Posts.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'userId: $userId,id : $id, title: $title, body: $body ';
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}
