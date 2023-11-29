import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import '/data/failure.dart';
import '/data/exception.dart';
import '/data/datasource/photo_upload_api.dart';
import '/repositories/photo_upload_repository.dart';

class PhotoUploadRepositoryImpl implements PhotoUploadRepository {
  final PhotoUploadApi authApi;

  PhotoUploadRepositoryImpl({required this.authApi});

  @override
  Future<Either<Failure, dynamic>> uploadPhotos({
    // required List<File> photos,
    
    required FilePickerResult photos,
    required StreamProgressIndicator streamProgress,
  }) async {
    try {
      // final ProfileModel result =
      await authApi.uploadPhotos(
          photos: photos, streamProgress: streamProgress);
      // return Right(result.toEntity());
      return const Right('');
    } on ServerException {
      return const Left(ServerFailure('Server error'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (error) {
      final message = error.response?.data['message'] as String;
      return Left(BadRequestFailure(message));
    }
  }
}
