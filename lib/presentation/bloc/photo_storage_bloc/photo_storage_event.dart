import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:photo_uploader/data/datasource/photo_upload_api.dart';

abstract class PhotoStorageEvent extends Equatable {
  const PhotoStorageEvent();

  @override
  List<Object?> get props => [];
}

class OnUploadPhotos extends PhotoStorageEvent {
  final FilePickerResult photos;
  final StreamProgressIndicator streamProgress;
  final VoidCallback clearImageCount;

  const OnUploadPhotos({
    required this.photos,
    required this.streamProgress,
    required this.clearImageCount,
  });

  @override
  List<Object?> get props => [];
}
