part of 'actions_post_bloc.dart';

abstract class ActionsPostStateBloc extends Equatable {
  @override
  List<Object> get props => [];
}

class ActionsPostInitialBloc extends ActionsPostStateBloc {}

class ActionPostLoadingStateBloc extends ActionsPostStateBloc {}

class ActionPostSuccessStateBloc extends ActionsPostStateBloc {
  final String message;

  ActionPostSuccessStateBloc({required this.message});
}

class ActionPostErrorStateBloc extends ActionsPostStateBloc {
  final String message;

  ActionPostErrorStateBloc({required this.message});
}
