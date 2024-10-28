import 'package:equatable/equatable.dart';

abstract class Actions_postState extends Equatable {
  @override
  List<Object> get props => [];
}

class ActionPostInitial extends Actions_postState {}

class ActionPostLoadingState extends Actions_postState {}

class ActionPostSuccessState extends Actions_postState {
  final String message;

  ActionPostSuccessState({required this.message});
}

class ActionPostErrorState extends Actions_postState {
  final String message;

  ActionPostErrorState({required this.message});
}
