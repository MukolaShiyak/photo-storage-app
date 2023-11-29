import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:photo_uploader/data/datasource/photo_upload_api.dart';

import '/data/failure.dart';

abstract class PhotoUploadRepository {
  Future<Either<Failure, dynamic>> uploadPhotos({
    // required List<File> photos,

    required FilePickerResult photos,
    required StreamProgressIndicator streamProgress,
  });
}
