import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_uploader/presentation/bloc/photo_storage_bloc/photo_storage_bloc.dart';

import '/routes.dart';
import 'injector.dart' as di;
import '/utils/interceptor.dart';
import '/presentation/bloc/auth_bloc/auth_bloc.dart';

late Routes routes;
void main() {
  routes = Routes();
  di.init();
  di.locator.get<HttpInterceptor>();
  runApp(MyApp(routes: routes));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.routes,
  });
  final Routes routes;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.locator<AuthBloc>(),
        ),
        BlocProvider<PhotoStorageBloc>(
          create: (context) => di.locator<PhotoStorageBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: routes.onGenerateRoute,
        // initialRoute: '/',
      ),
    );
  }
}
