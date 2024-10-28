import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/exceptions.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/domain/repositories/repository_domain.dart';

import '../../../../core/network/network_info.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';

// عملت نوع جديد وسميته واستخدمته تحت
typedef DeleteOrAddOrUpdate = Future<Unit> Function();

class RepositoryData implements PostRepositoryDomain {
// بيتكلم مع الداتا سورس
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RepositoryData({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    // بشوف فيه نت ولا لا؟
    if (await networkInfo.isConnected) {
      try {
        // هات من الريموت كل البوستات
        final remotePosts = await remoteDataSource.getAllPosts();
        // ابعتها لل لوكال
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        // لو فيه مشكلة فالسيرفر
        return Left(ServerFailure());
      }
    } else {
      try {
        // لو مافيش نت ابعتلي الداتا اللي اخدتها فال لوكال
        return Right(await localDataSource.getCachedPosts());
      } on EmptyCacheException {
        // لو فاضية قولي انها فاضية
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    // باخد اللي اتكت في ال entities وببعته لل model
    final PostModel postModel = PostModel(title: post.title, body: post.body);
    return await _getMessage(() => remoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _getMessage(() => remoteDataSource.deletePost(id));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    // باخد اللي اتكت في ال entities وببعته لل model
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() => remoteDataSource.updatePost(postModel));
  }

  // العشان الكود متكرر في ال3 فانكشنز فجيبته هنا عشان مافضلش اكرر كتابته
  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrAddOrUpdate deleteOrAddOrUpdate) async {
    // هل فيه انترنت ولا لا؟
    if (await networkInfo.isConnected) {
      try {
        // هايتحط هنا الفانكشن اللي جيا من الريموت داتا سورس
        await deleteOrAddOrUpdate();
        // كأنك بتقوله انها void
        return const Right(unit);
      } on ServerException {
        // لو فيه مشكلة فالسيرفر هايرجع
        return Left(ServerFailure());
      }
    } else {
      // لو مافيش نت رجع خطا الاوفلاين
      return Left(OfflineFailure());
    }
  }
}
