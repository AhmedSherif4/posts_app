import 'package:bloc/bloc.dart';

import '../../../../../core/strings/failure.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/add_post.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';
import 'actions_post_state.dart';

class Actions_postCubit extends Cubit<Actions_postState> {
  final AppPostUsecase addPostUsecase;
  final DeletePostUsecase deletePostUsecase;
  final UpdatePostUsecase updatePostUsecase;

  Actions_postCubit(
      {required this.addPostUsecase,
      required this.deletePostUsecase,
      required this.updatePostUsecase})
      : super(ActionPostInitial());

  void addPost(Post post) async {
    emit(ActionPostLoadingState());
    final failureOrAdd = await addPostUsecase(post);
    failureOrAdd.fold(
      (failure) =>
          emit(ActionPostErrorState(message: mapFailureToMessage(failure))),
      (_) => emit(ActionPostSuccessState(message: addSuccessMessage)),
    );
  }

  void updatePost(Post post) async {
    emit(ActionPostLoadingState());
    final failureOrAdd = await updatePostUsecase(post);
    failureOrAdd.fold(
          (failure) =>
          emit(ActionPostErrorState(message: mapFailureToMessage(failure))),
          (_) => emit(ActionPostSuccessState(message: updatedSuccessMessage)),
    );
  }

  void deletePost(int postId) async {
    emit(ActionPostLoadingState());
    final failureOrAdd = await deletePostUsecase(postId);
    failureOrAdd.fold(
          (failure) =>
          emit(ActionPostErrorState(message: mapFailureToMessage(failure))),
          (_) => emit(ActionPostSuccessState(message: deleteSuccessMessage)),
    );
  }


}
