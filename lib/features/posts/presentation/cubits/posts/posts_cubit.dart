import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_app/core/strings/failure.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/get_all_posts.dart';
import 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final GetAllPostsUsecase getAllPostsUsecase;

  PostsCubit({required this.getAllPostsUsecase}) : super(PostsInitial());

  void getAllPosts() async {
    emit(PostsLoadingState());
    final Either<Failure, List<Post>> failureOrPosts =
        await getAllPostsUsecase();
    failureOrPosts.fold(
      (failure) {
        emit(PostsErrorState(message: mapFailureToMessage(failure)));
      },
      (posts) {
        emit(PostsSuccessState(posts: posts));
      },
    );
  }

  void refreshPosts() async {
    emit(PostsLoadingState());
    final Either<Failure, List<Post>> failureOrPosts =
        await getAllPostsUsecase();
    failureOrPosts.fold(
      (failure) {
        emit(PostsErrorState(message: mapFailureToMessage(failure)));
      },
      (posts) {
        emit(PostsSuccessState(posts: posts));
      },
    );
  }
}
