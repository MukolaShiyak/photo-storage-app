import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:photo_uploader/data/datasource/photo_upload_api.dart';

abstract class PhotoStorageEvent extends Equatable {
  const PhotoStorageEvent();

  @override
  List<Object?> get props => [];
}

class OnUploadPhotos extends PhotoStorageEvent {
  // final List<File> photos;
  final FilePickerResult photos;
  final StreamProgressIndicator streamProgress;

  const OnUploadPhotos({
    required this.photos,
    required this.streamProgress,
  });

  @override
  List<Object?> get props => [];
}
