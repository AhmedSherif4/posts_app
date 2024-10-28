import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/repository_domain.dart';

// بربط مابين الحالات هنا وبين الريبوستوري

class DeletePostUsecase {
  final PostRepositoryDomain repository;

  DeletePostUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}
