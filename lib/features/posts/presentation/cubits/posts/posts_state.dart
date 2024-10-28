import 'package:equatable/equatable.dart';

import '../../../domain/entities/post.dart';

abstract class PostsState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsSuccessState extends PostsState {
  final List<Post> posts;

  PostsSuccessState({required this.posts});

  @override
  List<Object> get props => [posts];
}

class PostsErrorState extends PostsState {
  final String message;

  PostsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
