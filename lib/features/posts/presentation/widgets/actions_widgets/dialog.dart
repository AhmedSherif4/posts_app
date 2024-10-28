import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/snackbar_message.dart';
import 'package:posts_app/features/posts/presentation/blocs/actions_post/actions_post_bloc.dart';
import 'package:posts_app/features/posts/presentation/pages/posts_page.dart';

import '../../../../../core/widgets/loading_widget.dart';

deleteDialog({required BuildContext context, required int postId}) {
  showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<ActionsPostBloc, ActionsPostStateBloc>(
          listener: (context, state) {
            if (state is ActionPostSuccessStateBloc) {
              showSnackBar(
                  context: context,
                  message: state.message,
                  color: Colors.green);

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const PostsPage(),
                  ),
                  (route) => false);
            }
            if (state is ActionPostErrorStateBloc) {
              Navigator.of(context).pop();
              showSnackBar(
                  context: context, message: state.message, color: Colors.red);
            }
          },
          builder: (context, state) {
            if (state is ActionPostLoadingStateBloc) {
              return const AlertDialog(
                title: LoadingWidget(),
              );
            }
            return deleteDialogWidget(context: context, postId: postId);
          },
        );
      });
}

deleteDialogWidget({required BuildContext context, required int postId}) {
  return AlertDialog(
    title: const Text("Are you Sure ?"),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text(
          "No",
        ),
      ),
      TextButton(
        onPressed: () {
          BlocProvider.of<ActionsPostBloc>(context).add(
            DeletePostsEventBloc(postId: postId),
          );
        },
        child: const Text("Yes"),
      ),
    ],
  );
}
