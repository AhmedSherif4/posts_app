part of 'posts_bloc.dart';

abstract class PostsStateBloc extends Equatable {
  @override
  List<Object> get props => [];
}

class PostsInitialBloc extends PostsStateBloc {}

class PostsLoadingStateBloc extends PostsStateBloc{}

class PostsSuccessStateBloc extends PostsStateBloc{
  final List<Post> posts;

  PostsSuccessStateBloc({required this.posts});
}

class PostsErrorStateBloc extends PostsStateBloc{
  final String message;

  PostsErrorStateBloc({required this.message});

}