part of 'post_bloc.dart';

@immutable
abstract class PostEvent extends Equatable {
  const PostEvent();
}

class PostRetreve extends PostEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CommentsRetrieve extends PostEvent {
  final Posts postToOpen;
  const CommentsRetrieve({@required this.postToOpen});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
