import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:posts_app/core/errors/exceptions.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int postId);

  Future<Unit> updatePost(PostModel postModel);

  Future<Unit> addPost(PostModel postModel);
}

const String baseURI = 'https://jsonplaceholder.typicode.com';

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    // دخلت اللينك
    final response = await client.get(Uri.parse('$baseURI/posts/'),
        headers: {'Content-type': 'application/json'});
    // لو اللينك تمام
    if (response.statusCode == 200) {
      // جيبلي اللي جوا البوستز ك ليست
      final List decodeJson = jsonDecode(response.body) as List;
      // حول لي الجيسون اللي جاي ماللينك إلى بوست موديل
      final List<PostModel> postModel = decodeJson
          .map<PostModel>((jsonPostMode) => PostModel.fromJson(jsonPostMode))
          .toList();
      return Future.value(postModel);
    } else {
      // لو حصل مشكله قول انها بتاعت السيرفر
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    // اخدت البوست الجديد as map
    final Map body = {'title': postModel.title, 'body': postModel.body};
    // بعته لل لينك وبعتله الbody
    final response =
        await client.post(Uri.parse('$baseURI/posts/'), body: body);
    // بشوف لو فيه ايرور ولا الدنيا تمام
    // 201 دا الرقم أما ب post حاجة
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    String stringPostId = postId.toString();
    // بمسح من اللينك على أساس ال id اللي انا جايبه وحددتله الهيدر
    final response = await client.delete(
        Uri.parse('$baseURI/posts/$stringPostId'),
        headers: {'Content-type': 'application/json'});
    // بشوف لو فيه ايرور ولا لا
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    String stringPostId = postModel.id.toString();
    // باخد الداتا الجديدة اللي جاية من الuser
    final Map body = {'title': postModel.title, 'body': postModel.body};
    // بعدّل على البوست صاحب ال id وبديله ال body
    final response = await client.patch(
      Uri.parse('$baseURI/posts/$stringPostId'),
      body: body,
    );
    // بشوف لو فيه ايرور ولا لا
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
