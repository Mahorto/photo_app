import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:photo_app/core/platform/network_info.dart';
import 'package:photo_app/feature/data/datasource/photo_datasourse.dart';
import 'package:photo_app/feature/data/datasource/photo_local_datasource.dart';
import 'package:photo_app/feature/data/repository/photo_repository_imp.dart';
import 'package:photo_app/feature/domain/repository/photo_repository.dart';
import 'package:photo_app/feature/domain/usecases/get_all_photos.dart';
import 'package:photo_app/feature/presentation/cubit/photo_list_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Cubit
  sl.registerFactory(() => PhotoListCubit(getAllPhotos: sl()));

  //UseCase
  sl.registerLazySingleton(() => GetAllPhotos(sl()));

  //Repository
  sl.registerLazySingleton<PhotoRepository>(() => PhotoRepositoryImplement(
      photoDatasource: sl(), photoLocalDatasource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<PhotoDatasource>(
      () => PhotoDatasourceImplement(client: http.Client()));
  sl.registerLazySingleton<PhotoLocalDatasource>(
      () => PhotoLocalDatasourceImplements(sharedPreferences: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
