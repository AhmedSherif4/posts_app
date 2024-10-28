import 'package:equatable/equatable.dart';

// زي الموديل بس عام أكتر
class Post extends Equatable {
  final int? id;
  final String title;
  final String body;

  const Post({this.id, required this.title, required this.body});

  @override
  List<Object?> get props => [id, title, body];
}
