part of 'actions_post_bloc.dart';

abstract class ActionsPostEventBloc extends Equatable {
  @override
  List<Object> get props => [];
}

class AddPostsEventBloc extends ActionsPostEventBloc {
  final Post post;

  AddPostsEventBloc({required this.post});
}

class DeletePostsEventBloc extends ActionsPostEventBloc {
  final int postId;

  DeletePostsEventBloc({required this.postId});
}

class UpdatePostsEventBloc extends ActionsPostEventBloc {
  final Post post;

  UpdatePostsEventBloc({required this.post});
}
