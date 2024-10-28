import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/features/posts/data/data_sources/local_data_source.dart';
import 'package:posts_app/features/posts/data/data_sources/remote_data_source.dart';
import 'package:posts_app/features/posts/domain/repositories/repository_domain.dart';
import 'package:posts_app/features/posts/domain/usecases/delete_post.dart';
import 'package:posts_app/features/posts/domain/usecases/update_post.dart';
import 'package:posts_app/features/posts/presentation/blocs/actions_post/actions_post_bloc.dart';
import 'package:posts_app/features/posts/presentation/cubits/actions_post/actions_post_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/posts/data/repositories/repositories_data.dart';
import 'features/posts/domain/usecases/add_post.dart';
import 'features/posts/domain/usecases/get_all_posts.dart';
import 'features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'features/posts/presentation/cubits/posts/posts_cubit.dart';

final di = GetIt.instance;
// الفاكتوري لو هعمل منه اكتر من اوبجيت، البلوك ممكن اعمل منه اوبجيت لكل state وفي اكتر من مكان وكل واحد مختلف، فعشان كدا استخدمت فاكتوري، عشان ينظملي العملية دي
// الsingleton لو محتاج اعمل منه اوبجيت واحد بس، وايا كان المكان اللي هستخدمه يكون على نفس الاوبجيت،
// يعني مثلا الaddPost دي انا مش محتاج منها اكتر من اوبجيت، دي اوبجيت واحد واستخدمه بالعدد اللي انا عاوزه عادي

// بتقسم الاستدعائات اللي بتخش فالكلاس عن طريق الكونستراكتور، وكل حاجة بيخشلها جوا الكونسرتاكتور بتاعها حاجة، الحاجة اللي بتخش دي انت بتعرفها تحتيها
// البلوك بيحتاج الusecases ف رحت عرفته تحتيه
// الusecases بتحتاج الrepository ف رحت عرفته تحتيه
// الrepository بيحتاج للداتا سورس والانترنيت انفو، ف رحت عرفته تحتيه

Future<void> init() async {
  //! Feature Post

  // Bloc
  di.registerFactory(() => PostsBloc(getAllPostsUsecase: di()));
  di.registerFactory(() => ActionsPostBloc(
      addPostUsecase: di(), deletePostUsecase: di(), updatePostUsecase: di()));
  // Cubit
  di.registerFactory(() => PostsCubit(getAllPostsUsecase: di()));
  di.registerFactory(() => Actions_postCubit(
      addPostUsecase: di(), deletePostUsecase: di(), updatePostUsecase: di()));
  // Usecases
  di.registerLazySingleton(() => AppPostUsecase(repository: di()));
  di.registerLazySingleton(() => DeletePostUsecase(repository: di()));
  di.registerLazySingleton(() => GetAllPostsUsecase(repository: di()));
  di.registerLazySingleton(() => UpdatePostUsecase(repository: di()));

  // Repositories
  di.registerLazySingleton<PostRepositoryDomain>(() => RepositoryData(
      localDataSource: di(), networkInfo: di(), remoteDataSource: di()));

  // DataSources
  di.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPrefrences: di()));
  di.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: di()));

  //! Core
  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(di()));
  //! External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  di.registerLazySingleton(() => sharedPreferences);
  di.registerLazySingleton(() => http.Client());
  di.registerLazySingleton(() => InternetConnectionChecker());
}
