import 'package:equatable/equatable.dart';
import 'package:photo_app/feature/domain/entities/photo_entity.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();

  @override
  List<Object?> get props => [];
}

class PhotoEmpty extends PhotoState {
  @override
  List<Object?> get props => [];
}

class PhotoLoading extends PhotoState {
  final List<PhotoEntity> oldPhotoList;
  final bool isFirstFetch;

  PhotoLoading(this.oldPhotoList, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldPhotoList];
}

class PhotoLoaded extends PhotoState {
  final List<PhotoEntity> photoList;

  PhotoLoaded(this.photoList);

  @override
  List<Object?> get props => [photoList];
}

class PhotoError extends PhotoState {
  final String messageError;

  PhotoError({required this.messageError});

  @override
  List<Object?> get props => [messageError];
}
