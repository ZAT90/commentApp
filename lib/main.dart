
import 'package:comments/bloc/posts/post_bloc.dart';
import 'package:comments/comments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './splash.dart';
import './home.dart';
import 'bloc/setup/blocObserver.dart';
import 'bloc/theme/themeCubit.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(builder: (_, theme) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: theme,
          routes: {
            '/': (context) => SplashPage(),
            '/home': (context) =>BlocProvider(
          child: HomePage(),
          create: (context) =>
              PostBloc()..add(PostRetreve()),
            ),
            '/comments': (context) => CommentPage(),
            },
        );
      }),
    );
  }
}
