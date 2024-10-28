import 'package:flutter/material.dart';
import 'package:posts_app/features/posts/presentation/pages/actions_post_page.dart';

import '../../../domain/entities/post.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;

  const PostListWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(posts[index].title),
            leading:
                Text(posts[index].id.toString(), textAlign: TextAlign.center),
            minLeadingWidth: 15,
            subtitle: Text(posts[index].body),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ActionsPostPage(
                    isUpdatePost: true,
                    post: posts[index],
                  ),
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: posts.length);
  }
}
