import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:photo_uploader/data/datasource/photo_upload_api.dart';
import 'package:photo_uploader/data/repositories/photo_upload_repositories_impl.dart';
import 'package:photo_uploader/presentation/bloc/photo_storage_bloc/photo_storage_bloc.dart';
import 'package:photo_uploader/repositories/photo_upload_repository.dart';
import 'package:photo_uploader/services/Ifile_picker_service.dart';
import 'package:photo_uploader/services/file_picker_service.dart';
import 'package:photo_uploader/usecase/photo_upload.dart';

import '/usecase/auth.dart';
import '/utils/interceptor.dart';
import '/data/datasource/auth_api.dart';
import '/repositories/auth_repository.dart';
import '/presentation/bloc/auth_bloc/auth_bloc.dart';
import '/data/repositories/auth_repositories_impl.dart';

final locator = GetIt.instance;

void init() {
  print('injector initializing');
  // bloc
  locator.registerFactory(() => AuthBloc(locator()));
  locator.registerFactory(() => PhotoStorageBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => Auth(locator()));
  locator.registerLazySingleton(() => PhotoUpload(locator()));

  // repository
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authApi: locator(),
    ),
  );
  locator.registerLazySingleton<PhotoUploadRepository>(
    () => PhotoUploadRepositoryImpl(
      authApi: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<AuthApi>(
    () => AuthApiImpl(
      dio: locator(),
    ),
  );
  locator.registerLazySingleton<PhotoUploadApi>(
    () => PhotoUploadApiImpl(
      dio: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => Dio());
  locator.registerLazySingleton(() => const FlutterSecureStorage());
  locator.registerLazySingleton(() => HttpInterceptor(locator()));
  locator.registerLazySingleton<IFilePickerService>(() => FilePickerService());
}
