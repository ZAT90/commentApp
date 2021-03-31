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
  List<Comments> initComments = [];
  List<Comments> postComments = [];
  TextEditingController filterController = TextEditingController();
  String searchText = '';
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final postBloc = BlocProvider.of<PostBloc>(context);
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is GetPostAndComments) {
          post = state.post;
          postComments = state.postComments;
          initComments = state.postComments;
        } else if (state is GetFilteredComments) {
          postComments = state.comments;
          searchText = state.searchString;
          if (state.searchString.length == 0) {
            filterController.text = '';
          }
        }
        // TODO: implement listener
      },
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          debugPrint('initComments: $initComments');
          return Scaffold(
            appBar: AppBar(title: Text('Comments')),
            body: Container(
              padding: EdgeInsets.all(15),
              child: post != null
                  ? buildCommentView(
                      post, postComments, initComments, postBloc, searchText)
                  : Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.blue)),
            ),
          );
        },
      ),
    );
  }

  Column buildCommentView(Posts post, List<Comments> postComments,
      List<Comments> initComments, PostBloc postBloc, String searchText) {
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextFormField(
                    autocorrect: false,
                    controller: filterController,
                    onChanged: (value) {
                      postBloc.add(CommentsFilter(
                          searchString: value, comments: initComments));
                    },
                    decoration: InputDecoration(
                        hintText: 'Name, Email or body',
                        border: InputBorder.none),
                  ),
                ),
              ),
              searchText.length > 0
                  ? Expanded(
                      flex: 1,
                      child: IconButton(
                          icon: Icon(Icons.close_rounded),
                          onPressed: () {
                            postBloc.add(CommentsFilter(
                                searchString: '', comments: initComments));
                          }),
                    )
                  : SizedBox.shrink()
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
