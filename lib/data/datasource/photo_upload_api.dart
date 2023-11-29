import 'dart:async';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:photo_uploader/injector.dart';
import 'package:photo_uploader/services/Ifile_picker_service.dart';
// import 'package:http_parser/http_parser.dart';

import '/data/constants.dart';
// import '/data/exception.dart';
// import '/data/models/profile_model.dart';

abstract class PhotoUploadApi {
  Future<dynamic> uploadPhotos({
    // required List<File> photos,

    required FilePickerResult photos,
    required StreamProgressIndicator streamProgress,
  });
}

class PhotoUploadApiImpl implements PhotoUploadApi {
  final Dio dio;
  PhotoUploadApiImpl({required this.dio});

  @override
  Future<dynamic> uploadPhotos({
    // required List<File> photos,
    // required List<File> photos,
    required FilePickerResult photos,
    required StreamProgressIndicator streamProgress,
  }) async {
    print('${Urls.baseUrl}media/upload');

    print('convertedFiles0: $photos');

    final filePickerService = locator.get<IFilePickerService>();
    // var convertedFiles = photos
    //     .map(
    //       (file) async => await MultipartFile.fromFile(
    //         file.path,
    //         // contentType: MediaType("image", "jpg"),
    //       ),
    //     )
    //     .toList();

    // var convertedFiles =
    List<MultipartFile> convertedFiles = [];
    for (var i = 0; i < photos.files.length; i++) {
      if (photos.files[i].path == null) return;
      final convertedFile = await MultipartFile.fromFile(
        photos.files[i].path!,
      );
      convertedFiles.add(convertedFile);
    }

    print('convertedFiles: $convertedFiles');

    var formData = FormData.fromMap(
      <String, dynamic>{"files": convertedFiles},
    );

    print('convertedFiles2: ${formData.fields}');

    // final response =
    await dio.post('${Urls.baseUrl}media/upload',
        data: formData,
        options: Options(
          contentType: "multipart/form-data",
          receiveTimeout: const Duration(milliseconds: 2000000),
          sendTimeout: const Duration(milliseconds: 2000000),
          followRedirects: true,
        ), onSendProgress: (int sent, int total) {
      double progress = double.parse(((sent / total) * 100).toStringAsFixed(1));
      streamProgress.counterStream.add(progress);
    }).whenComplete(() async {
      await filePickerService.clearTemporaryFiles();
    });

    // if (response.statusCode != null &&
    //     response.statusCode! >= 200 &&
    //     response.statusCode! < 300) {
    //   ProfileModel data = ProfileModel.fromJson(response.data);

    //   return data;
    // } else {
    //   throw ServerException();
    // }
  }
}

class StreamProgressIndicator {
  StreamController<double> counterStream = StreamController<double>.broadcast();
}
