import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/snackbar_message.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:posts_app/features/posts/presentation/blocs/actions_post/actions_post_bloc.dart';
import 'package:posts_app/features/posts/presentation/pages/posts_page.dart';

import '../../domain/entities/post.dart';
import '../widgets/actions_widgets/form_widget.dart';

class ActionsPostPage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const ActionsPostPage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text(isUpdatePost ? 'Edit Post' : 'Add Post'),
        centerTitle: true,
        elevation: 0,
      );

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<ActionsPostBloc, ActionsPostStateBloc>(
          listener: (context, state) {
            if (state is ActionPostSuccessStateBloc) {
              showSnackBar(
                  context: context,
                  message: state.message,
                  color: Colors.green);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const PostsPage()),
                  (route) => false);
            }
            if (state is ActionPostErrorStateBloc) {
              showSnackBar(
                  context: context, message: state.message, color: Colors.red);
            }
          },
          builder: (context, state) {
            if (state is ActionPostLoadingStateBloc) {
              return const LoadingWidget();
            }
            // ماعملش احتمالات للباقي لأن الباقي كله هياخد نفس الويجدت
            return FormWidget(
              isUpdatePost: isUpdatePost,
              post: isUpdatePost ? post : null,
            );
          },
        ),
      ),
    );
  }
}
