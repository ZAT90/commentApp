part of 'post_bloc.dart';

@immutable
abstract class PostState extends Equatable{
  const PostState();
}

class PostInitial extends PostState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class GetAllPosts extends PostState{
  final List<Posts> allPosts;
  const GetAllPosts({@required this.allPosts});

  @override
  // TODO: implement props
  List<Object> get props => [allPosts];
}

class GetPostAndComments extends PostState{
  final Posts post;
  final List<Comments> postComments;
  const GetPostAndComments({@required this.post, @required this.postComments});
  @override
  // TODO: implement props
  List<Object> get props => [post,postComments];

}
