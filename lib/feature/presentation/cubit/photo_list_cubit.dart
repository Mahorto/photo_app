import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_app/core/error/failure.dart';
import 'package:photo_app/feature/domain/entities/photo_entity.dart';
import 'package:photo_app/feature/domain/usecases/get_all_photos.dart';
import 'package:photo_app/feature/presentation/cubit/photo_list_state.dart';

const serverFailureMess = 'Server failure';
const cacheFailureMess = 'Cache failure';

class PhotoListCubit extends Cubit<PhotoState> {
  final GetAllPhotos getAllPhotos;
  int page = 1;

  PhotoListCubit({required this.getAllPhotos}) : super(PhotoEmpty());

  void loadPhoto() async {
    final currState = state;
    var oldPhotos = <PhotoEntity>[];

    if (currState is PhotoLoading) return;

    if (currState is PhotoLoaded) {
      oldPhotos = currState.photoList;
    }
    emit(PhotoLoading(oldPhotos, isFirstFetch: page == 1));

    final isFailure = await getAllPhotos(PagePhotoParams(page: page));

    isFailure.fold(
        (error) => emit(PhotoError(messageError: _mapFailureToMess(error))),
        (photo) {
      page = page + 36;
      final photos = (state as PhotoLoading).oldPhotoList;
      photos.addAll(photo);
      emit(PhotoLoaded(photos));
    });
  }

  String _mapFailureToMess(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMess;
      case CacheFailure:
        return cacheFailureMess;
      default:
        return 'Unexpected Error';
    }
  }
}
