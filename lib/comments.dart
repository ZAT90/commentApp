import 'package:comments/bloc/posts/post_bloc.dart';
import 'package:comments/model/comment.dart';
import 'package:comments/model/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  Posts post;
  List<Comments> postComments = [];
  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is GetPostAndComments) {
          post = state.post;
          postComments = state.postComments;
        }
        // TODO: implement listener
      },
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (post == null) {}
          return Scaffold(
            appBar: AppBar(title: Text('Comments')),
            body: Container(
              padding: EdgeInsets.all(15),
              child: post != null
                  ? buildCommentView()
                  : Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.blue)),
            ),
          );
        },
      ),
    );
  }

  Column buildCommentView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Post',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 15),
        Container(
          color: Colors.blueAccent,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                post.body,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(height: 29),
        Text(
          'All comments',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text('filter your comments')),
              ),
              Expanded(flex: 1,child: Icon(Icons.arrow_drop_down),)
            ],
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: postComments.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            postComments[index].name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('email: ${postComments[index].email}'),
                        ],
                      ),
                      subtitle: Text('Comment: ${postComments[index].body}'),
                    ),
                  );
                }))
      ],
    );
  }
}
