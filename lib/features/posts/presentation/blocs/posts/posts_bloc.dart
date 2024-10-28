import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/strings/failure.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/get_all_posts.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEventBloc, PostsStateBloc> {
  final GetAllPostsUsecase getAllPostsUsecase;

  PostsBloc({required this.getAllPostsUsecase}) : super(PostsInitialBloc()) {
    on<PostsEventBloc>(
      (event, emit) async {
        if (event is GetAllPostsEventBloc) {
          emit(PostsLoadingStateBloc());
          final Either<Failure, List<Post>> failureOrPosts =
              await getAllPostsUsecase();
          failureOrPosts.fold(
            (failure) {
              emit(PostsErrorStateBloc(message: mapFailureToMessage(failure)));
            },
            (posts) {
              emit(PostsSuccessStateBloc(posts: posts));
            },
          );
        } else if (event is RefreshPostsEventBloc) {
          emit(PostsLoadingStateBloc());
          final Either<Failure, List<Post>> failureOrPosts =
              await getAllPostsUsecase();
          failureOrPosts.fold(
            (failure) {
              emit(PostsErrorStateBloc(message: mapFailureToMessage(failure)));
            },
            (posts) {
              emit(PostsSuccessStateBloc(posts: posts));
            },
          );
        }
      },
    );
  }
}
