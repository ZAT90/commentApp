import 'package:boilerplateflubloc/bloc/user.dart';
import 'package:boilerplateflubloc/model/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Homepage"),
        ),
        body: BlocProvider<UserBloc>(
            lazy: false,
            create: (context) =>
                UserBloc()..add(UserEvents(status: EventStatus.getUsers)),
            child: BlocBuilder<UserBloc, Users>(builder: (context, users) {
              List<Data> data = users.data;
              debugPrint('data: $data');
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'You have pushed the button this many times:',
                    ),
                    RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: (){ UserBloc()..add(UserEvents(value: 5,status: EventStatus.updateUsers)); },
                    child: new Text("Add"),
                  ),
                  ],
                ),
              );
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
