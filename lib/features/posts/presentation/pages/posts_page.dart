import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/pages/actions_post_page.dart';

import '../../../../core/refresh_function.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../widgets/posts_widget/message_display_widget.dart';
import '../widgets/posts_widget/post_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: const Text('Posts'),
        centerTitle: true,
        elevation: 0,
      );

  Widget _buildBody() => Padding(
        padding: const EdgeInsets.all(10),
        child:
            BlocBuilder<PostsBloc, PostsStateBloc>(builder: (context, state) {
          if (state is PostsLoadingStateBloc) {
            return const LoadingWidget();
          } else if (state is PostsSuccessStateBloc) {
            return RefreshIndicator(
              child: PostListWidget(posts: state.posts),
              onRefresh: () => onRefresh(context),
            );
          } else if (state is PostsErrorStateBloc) {
            // ريفريش انديكيتور مابتشتغلش غير مع حاجة سكرولابل، ولكن ليست فيو هاتخلي السنتر مالهوش لازمة
            // فعشان كدا خليت فيه ستاك جواه ليست فيو وجنبه الحاجة اللي انا عاوزها
            return MessageDisplayWidget(message: state.message);
          } else {
            return const LoadingWidget();
          }
        }),
      );

  _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ActionsPostPage(
              isUpdatePost: false,
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
