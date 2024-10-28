import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/posts/presentation/blocs/posts/posts_bloc.dart';

Future<void> onRefresh(BuildContext context) async {
  BlocProvider.of<PostsBloc>(context).add(RefreshPostsEventBloc());
}