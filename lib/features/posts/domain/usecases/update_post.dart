import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/post.dart';
import '../repositories/repository_domain.dart';

// بربط مابين الحالات هنا وبين الريبوستوري

class UpdatePostUsecase {
  final PostRepositoryDomain repository;

  UpdatePostUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}
