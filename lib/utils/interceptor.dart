import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/injector.dart';
import '/utils/request_retrier.dart';
import '/data/secure_storage_keys.dart';
import '/presentation/bloc/auth_bloc/auth_bloc.dart';
import '/presentation/bloc/auth_bloc/auth_event.dart';

class HttpInterceptor {
  final AuthBloc authBloc;
  bool isRefreshing = false;

  HttpInterceptor(this.authBloc) {
    final dio = locator.get<Dio>();
    final storage = locator.get<FlutterSecureStorage>();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          final token = await storage.read(key: SecureStorageKeys.accessToken);

          if (token != null) {
            try {
              print('interceptor token: $token');
              options.headers
                  .addAll(<String, dynamic>{'Authorization': 'Bearer $token'});
            } catch (e) {
              print(e);
            }
          }

          print('print_headers: ${options.headers.toString()}');

          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (
          DioError e,
          ErrorInterceptorHandler handler,
        ) async {
          final String? refreshToken =
              await storage.read(key: SecureStorageKeys.refreshToken);
          final String requestPath = e.requestOptions.path;

          final List<int> listOfStatusCodes = [400, 401, 403];

          dynamic isSuccessful;
          if (e.response != null &&
              e.response!.statusCode == 401 &&
              refreshToken != null &&
              !requestPath.contains('refresh')) {
            if (isRefreshing) {
              return handler.reject(e);
            } else {
              authBloc.add(OnRefreshToken(refreshToken: refreshToken));

              await Future.delayed(const Duration(seconds: 2));

              final String? newToken =
                  await storage.read(key: SecureStorageKeys.refreshToken);

              if (refreshToken != newToken) isSuccessful = true;
              isRefreshing = true;
            }
          } else if (listOfStatusCodes.contains(e.response?.statusCode) &&
              requestPath.contains('refresh')) {
            isRefreshing = false;
            authBloc.add(const OnLogOut());
          }

          if (isSuccessful == true) {
            print('handler.resolve');
            return handler.resolve(await DioHttpRequestRetrier(dio: dio)
                .requestRetry(e.requestOptions));
            // isSuccessful = false;
          } else {
            // print('handler.reject');
            // return handler.reject(e);

            print('handler.next');
            return handler.next(e);
          }

          // print('handler.next');
          // return handler.next(e);
        },
      ),
    );

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }
}
