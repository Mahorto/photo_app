import 'package:photo_app/core/error/exception.dart';
import 'package:photo_app/core/platform/network_info.dart';
import 'package:photo_app/feature/data/datasource/photo_datasourse.dart';
import 'package:photo_app/feature/data/datasource/photo_local_datasource.dart';
import 'package:photo_app/feature/domain/entities/photo_entity.dart';
import 'package:photo_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:photo_app/feature/domain/repository/photo_repository.dart';

class PhotoRepositoryImplement implements PhotoRepository {
  final PhotoDatasource photoDatasource;
  final PhotoLocalDatasource photoLocalDatasource;
  final NetworkInfo networkInfo;

  PhotoRepositoryImplement(
      {required this.photoDatasource,
      required this.photoLocalDatasource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PhotoEntity>>> getAllPhotos(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePhoto = await photoDatasource.getAllPhotos(page);
        photoLocalDatasource.photosToCahce(remotePhoto);
        return Right(remotePhoto);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locatePhoto = await photoLocalDatasource.getLastPhotosFromCache();
        return Right(locatePhoto);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
