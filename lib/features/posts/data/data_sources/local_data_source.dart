import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/exceptions.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> cachePosts(List<PostModel> postModels);
}

const String cachedPosts = 'CACHED_POSTS';

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPrefrences;

  PostLocalDataSourceImpl({required this.sharedPrefrences});

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    // اخدنا البوستات عن طريق البراميتر
    // خزناهم في ليستة ولكن حولناهم ل json
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    // encode بيحول أي حاجة ل jsonString
    // بنخزن الليست اللي جبناها دي جوا ال sharedPrefrences
    sharedPrefrences.setString(cachedPosts, jsonEncode(postModelsToJson));
    // علشان unit لوحدها كدا قيمتها ب unit مش فيوتشر، فعشان كدا استخدمنا value
    // value بتاخد النوع اللي هاتديهولها وبتعامله as future
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    // بناخد الداتا اللي خزناها
    final String? jsonString = sharedPrefrences.getString(cachedPosts);
    // لو مش فاضية :
    if (jsonString != null) {
      // جيبلي ال json دا جوا ليست
      List decodeJsonData = jsonDecode(jsonString);
      // حولي الجيسون إلى بوست موديل بعد كدا حطه تاني فالليست
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      // لو فاضي ابعتله انه فاضي
      throw EmptyCacheException();
    }
  }
}
