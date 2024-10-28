import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/post.dart';
// لامم الحالات كلها في مكان واحد
abstract class PostRepositoryDomain {

 Future<Either<Failure, List<Post>>> getAllPosts();
 Future<Either<Failure, Unit>> deletePost(int id);
 Future<Either<Failure, Unit>> updatePost(Post post);
 Future<Either<Failure, Unit>> addPost(Post post);


}