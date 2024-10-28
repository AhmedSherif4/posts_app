part of 'posts_bloc.dart';

abstract class PostsEventBloc extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllPostsEventBloc extends PostsEventBloc{}

class RefreshPostsEventBloc extends PostsEventBloc{}
