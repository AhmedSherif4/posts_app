import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/presentation/blocs/actions_post/actions_post_bloc.dart';
import 'package:posts_app/features/posts/presentation/widgets/actions_widgets/submit_button.dart';

import '../../../domain/entities/post.dart';
import 'textformfield_widget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;

  const FormWidget({Key? key, required this.isUpdatePost, this.post})
      : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: showTextFormField(
                  controller: _titleController, isTitle: true, name: 'Title'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: showTextFormField(
                controller: _bodyController,
                name: 'Body',
                isTitle: false,
              ),
            ),
            showAddUpdateBtn(
                isUpdatePost: widget.isUpdatePost,
                onPressed: validateFormThenUpdateOrAddPost),
            if (widget.isUpdatePost)
              showDeleteBtn(context: context, postId: widget.post!.id!)
          ],
        ),
      ),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final Post post = Post(
        title: _titleController.text,
        body: _bodyController.text,
        id: widget.isUpdatePost ? widget.post!.id : null,
      );
      if (widget.isUpdatePost) {
        BlocProvider.of<ActionsPostBloc>(context)
            .add(UpdatePostsEventBloc(post: post));
        print(post);
      } else {
        BlocProvider.of<ActionsPostBloc>(context)
            .add(AddPostsEventBloc(post: post));
        print(post);
      }
    }
  }
}
