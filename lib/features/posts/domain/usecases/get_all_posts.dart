import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/post.dart';
import '../repositories/repository_domain.dart';

// بربط مابين الحالات هنا وبين الريبوستوري

class GetAllPostsUsecase {
  final PostRepositoryDomain repository;

  GetAllPostsUsecase({required this.repository});

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
