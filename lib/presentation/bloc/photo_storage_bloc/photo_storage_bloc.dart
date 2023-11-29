import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/usecase/photo_upload.dart';
import '/presentation/bloc/photo_storage_bloc/photo_storage_event.dart';
import '/presentation/bloc/photo_storage_bloc/photo_storage_state.dart';

class PhotoStorageBloc extends Bloc<PhotoStorageEvent, PhotoStorageState> {
  final PhotoUpload _photoUpload;

  PhotoStorageBloc(
    this._photoUpload,
  ) : super(const PhotoStorageState()) {
    on<OnUploadPhotos>(
      _uploadPhotos,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  Future<void> _uploadPhotos(
      OnUploadPhotos event, Emitter<PhotoStorageState> emit) async {
    emit(state.copyWith(status: () => PhotoStorageStatus.loading));
    final photos = event.photos;
    final progress = event.streamProgress;

    final result = await _photoUpload.uploadPhotos(
      photos: photos,
      streamProgress: progress,
    );

    result.fold(
      (failure) {
        print('failure: ${failure.message}');
        emit(state.copyWith(
          status: () => PhotoStorageStatus.failure,
          errorMessage: () => failure.message,
        ));
        event.clearImageCount();
      },
      (data) {
        emit(state.copyWith(status: () => PhotoStorageStatus.success));
        event.clearImageCount();
      },
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
