import '../../domain/entities/post.dart';
// باخد اكستند من الانتيتي عشان اشوفه هو عاوز اية وهبعتهوله، عاوز داتا؟ عينيا حاضر هبعتهالك عن طريق السوبر ياحبيب اخوك
class PostModel extends Post {
  const PostModel({int? id, required String title, required String body})
      : super(id: id, title: title, body: body);
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(id: json['id'], title: json['title'], body: json['body']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'body': body};
  }
}
