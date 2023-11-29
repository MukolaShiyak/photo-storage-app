import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/routes.dart';
import '/injector.dart';
import '/data/secure_storage_keys.dart';
import '/presentation/bloc/profile_state.dart';
import '/presentation/bloc/auth_bloc/auth_bloc.dart';
import '/presentation/shared_widgets/api_loader.dart';
import '/presentation/bloc/auth_bloc/auth_event.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storage = locator.get<FlutterSecureStorage>();
  ProfileStateStatus _stateStatus = ProfileStateStatus.loading;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final authBloc = context.read<AuthBloc>();
      final token = await storage.read(key: SecureStorageKeys.accessToken);
      final refreshToken =
          await storage.read(key: SecureStorageKeys.refreshToken);

      print('token: $token');
      if (token != null) {
        authBloc.add(OnSetTokens(
          accessToken: token,
          refreshToken: refreshToken!,
        ));
      } else {
        authBloc.add(const OnEmptyState());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, ProfileState>(
        listener: (context, state) {
          setState(() => _stateStatus = state.status);

          if (
              // state is ProfileStateEmpty
              state.status == ProfileStateStatus.initial) {
            Navigator.of(context).pushReplacementNamed(Routes.signUp);
          } else if (state.status == ProfileStateStatus.success &&
              state.getProfile != null &&
              // state is ProfileStateHasData &&
              state.getProfile!.userId.isEmpty) {
            context.read<AuthBloc>().add(const OnGetUser());
          } else if (state.status == ProfileStateStatus.success &&
              state.getProfile != null &&
              // state is ProfileStateHasData &&
              state.getProfile!.userId.isNotEmpty) {
            Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
          }
        },
        child: Stack(
          children: [
            const Center(
              child: Text('Best app for save phone memmory'),
            ),
            if (_stateStatus == ProfileStateStatus.loading) const ApiLoader(),
          ],
        ),
      ),
    );
  }
}
