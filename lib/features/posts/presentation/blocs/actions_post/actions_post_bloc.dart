import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/strings/failure.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/add_post.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';

part 'actions_post_event.dart';

part 'actions_post_state.dart';

class ActionsPostBloc extends Bloc<ActionsPostEventBloc, ActionsPostStateBloc> {
  final AppPostUsecase addPostUsecase;
  final DeletePostUsecase deletePostUsecase;
  final UpdatePostUsecase updatePostUsecase;

  ActionsPostBloc({
    required this.addPostUsecase,
    required this.deletePostUsecase,
    required this.updatePostUsecase,
  }) : super(ActionsPostInitialBloc()) {
    on<ActionsPostEventBloc>(
      (event, emit) async {
        if (event is AddPostsEventBloc) {
          emit(ActionPostLoadingStateBloc());
          final failureOrAdd = await addPostUsecase(event.post);
          failureOrAdd.fold(
            (failure) => emit(ActionPostErrorStateBloc(
                message: mapFailureToMessage(failure))),
            (_) => emit(ActionPostSuccessStateBloc(message: addSuccessMessage)),
          );
        }
        else if (event is UpdatePostsEventBloc) {
          emit(ActionPostLoadingStateBloc());
          final failureOrAdd = await updatePostUsecase(event.post);
          failureOrAdd.fold(
            (failure) => emit(ActionPostErrorStateBloc(
                message: mapFailureToMessage(failure))),
            (_) => emit(
                ActionPostSuccessStateBloc(message: updatedSuccessMessage)),
          );
        }
        else if (event is DeletePostsEventBloc) {
          emit(ActionPostLoadingStateBloc());
          final failureOrAdd = await deletePostUsecase(event.postId);
          failureOrAdd.fold(
            (failure) => emit(ActionPostErrorStateBloc(
                message: mapFailureToMessage(failure))),
            (_) =>
                emit(ActionPostSuccessStateBloc(message: deleteSuccessMessage)),
          );
        }
      },
    );
  }
}
