import 'package:comments/bloc/posts/post_bloc.dart';
import 'package:comments/comments.dart';
import 'package:comments/model/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash.dart';
import 'storage/preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Posts> allPosts = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final postBloc = BlocProvider.of<PostBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Homepage"),
        ),
        body: BlocListener<PostBloc, PostState>(listener: (context, state) {
          if (state is GetAllPosts) {
            allPosts = state.allPosts;
          }
        }, child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
          debugPrint('state in PostBloc : $state');
          return Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    'All Posts',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  allPosts.length == 0?Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.blue)):Expanded(
                    // padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: allPosts.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                              create: (context) => PostBloc()
                                                ..add(CommentsRetrieve(
                                                    postToOpen:
                                                        allPosts[index])),
                                              child: CommentPage(),
                                            )));
                                
                              },
                              title: Text(allPosts[index].title),
                              subtitle: Text(
                                allPosts[index].body,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ));
        }))
        // Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       Text(
        //         'You have pushed the button this many times:',
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
