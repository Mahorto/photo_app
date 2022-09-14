import 'package:dartz/dartz.dart';
import 'package:photo_app/core/error/failure.dart';
import 'package:photo_app/feature/domain/entities/photo_entity.dart';

abstract class PhotoRepository {
  Future<Either<Failure, List<PhotoEntity>>> getAllPhotos(int page);
}
