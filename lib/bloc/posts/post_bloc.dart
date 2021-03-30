import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comments/api/commentAPI.dart';
import 'package:comments/api/postApi.dart';
import 'package:comments/model/comment.dart';
import 'package:comments/model/post.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial());
  PostAPI postAPI = PostAPI();
  CommentAPI commentAPI = CommentAPI();

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is PostRetreve) {
      yield* mapAllPosts();
    } else if (event is CommentsRetrieve) {
      yield* mapAllComments(event);
    }
  }

  Stream<PostState> mapAllPosts() async* {
    Response postRes = await postAPI.getPosts();
    List<Posts> allPosts =
        (postRes.data as List).map((e) => Posts.fromJson(e)).toList();
    yield GetAllPosts(allPosts: allPosts);
    debugPrint('allPosts: $allPosts');
  }

  Stream<PostState> mapAllComments(CommentsRetrieve event) async* {
    debugPrint('event data: ${event.postToOpen}');
    Response commentRes = await commentAPI.getComments(event.postToOpen.id);
    List<Comments> postComments =
        (commentRes.data as List).map((e) => Comments.fromJson(e)).toList();
    debugPrint('event postComments: $postComments}');
    yield GetPostAndComments(post: event.postToOpen, postComments: postComments,);
    yield PostInitial();

  }
}
