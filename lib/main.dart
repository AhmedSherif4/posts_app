import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/theme.dart';
import 'package:posts_app/features/posts/presentation/blocs/actions_post/actions_post_bloc.dart';
import 'package:posts_app/features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/cubits/actions_post/actions_post_cubit.dart';
import 'package:posts_app/features/posts/presentation/cubits/posts/posts_cubit.dart';

import 'features/posts/presentation/pages/posts_page.dart';
import 'injection_container.dart' as dependency_injection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          // bloc
          BlocProvider(
              create: (_) => dependency_injection.di<PostsBloc>()
                ..add(GetAllPostsEventBloc())),
          BlocProvider(
              create: (_) => dependency_injection.di<ActionsPostBloc>()),
          // cubit
          BlocProvider(create: (_) => dependency_injection.di<PostsCubit>()),
          BlocProvider(
              create: (_) => dependency_injection.di<Actions_postCubit>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          //darkTheme: darkTheme,
          title: 'Posts',
          theme: appTheme,
          home: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //return const ActionsPostPage(isUpdatePost: false);
    return const PostsPage();
  }
}
