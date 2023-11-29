import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/injector.dart';
import '/usecase/auth.dart';
import '/data/secure_storage_keys.dart';
import '/domain/entities/profile_entity.dart';
import '/presentation/bloc/profile_state.dart';
import '/presentation/bloc/auth_bloc/auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, ProfileState> {
  final Auth _auth;

  AuthBloc(
    this._auth,
  ) : super(ProfileState.initial()) {
    on<OnSignIn>(
      _onSignIn,
      // (event, emit) async {
      //   emit(ProfileStateLoading());
      //   final email = event.email;
      //   final password = event.password;
      //   final secureStorage = locator.get<FlutterSecureStorage>();

      //   final result = await _auth.signIn(
      //     email: email,
      //     password: password,
      //   );

      //   result.fold(
      //     (failure) {
      //       print('failure: ${failure.message}');
      //       emit(ProfileStateError(failure.message));
      //     },
      //     (data) {
      //       emit(ProfileStateHasData(data));

      //       secureStorage.write(
      //           key: SecureStorageKeys.accessToken, value: data.accessToken);
      //       secureStorage.write(
      //           key: SecureStorageKeys.refreshToken, value: data.refreshToken);
      //     },
      //   );
      // },
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    on<OnSignUp>(
      _onSignUp,
      // (event, emit) async {
      //   emit(ProfileStateLoading());
      //   final firstName = event.firstName;
      //   final lastName = event.lastName;
      //   final email = event.email;
      //   final password = event.password;
      //   final secureStorage = locator.get<FlutterSecureStorage>();

      //   final result = await _auth.signUp(
      //     firstName: firstName,
      //     lastName: lastName,
      //     email: email,
      //     password: password,
      //   );

      //   result.fold(
      //     (failure) {
      //       print('failure: ${failure.message}');
      //       emit(ProfileStateError(failure.message));
      //     },
      //     (data) {
      //       emit(ProfileStateHasData(data));

      //       secureStorage.write(
      //           key: SecureStorageKeys.accessToken, value: data.accessToken);
      //       secureStorage.write(
      //           key: SecureStorageKeys.refreshToken, value: data.refreshToken);
      //     },
      //   );
      // },
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    on<OnGetUser>(
      _onGetUser,
      // (event, emit) async {
      //   Profile? oldProfile;
      //   if (state is ProfileStateHasData) {
      //     oldProfile = state.getProfile;
      //   }

      //   emit(ProfileStateLoading());
      //   final result = await _auth.getUser();

      //   result.fold(
      //     (failure) {
      //       print('failure: ${failure.message}');
      //       emit(ProfileStateError(failure.message));
      //     },
      //     (data) {
      //       emit(
      //         ProfileStateHasData(
      //           Profile(
      //             email: data.email,
      //             firstName: data.firstName,
      //             lastName: data.lastName,
      //             userId: data.userId,
      //             accessToken: oldProfile?.accessToken ?? '',
      //             refreshToken: oldProfile?.refreshToken ?? '',
      //           ),
      //         ),
      //       );
      //     },
      //   );
      // },
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    on<OnSetTokens>(
      _onSetTokens,
      // (event, emit) async {
      //   final accessToken = event.accessToken;
      //   final refreshToken = event.refreshToken;

      //   emit(
      //     ProfileStateHasData(
      //       Profile(
      //         userId: '',
      //         firstName: '',
      //         lastName: '',
      //         email: '',
      //         accessToken: accessToken,
      //         refreshToken: refreshToken,
      //       ),
      //     ),
      //   );
      // },
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    on<OnRefreshToken>(
      _onRefreshToken,
      // (event, emit) async {
      //   Profile? oldProfile;
      //   if (state is ProfileStateHasData) {
      //     oldProfile = state.getProfile;
      //   }

      //   emit(ProfileStateLoading());

      //   final refreshToken = event.refreshToken;
      //   final secureStorage = locator.get<FlutterSecureStorage>();

      //   final result = await _auth.refreshToken(refreshToken: refreshToken);

      //   result.fold(
      //     (failure) {
      //       print('failure: ${failure.message}');
      //       emit(ProfileStateError(failure.message));
      //     },
      //     (data) {
      //       emit(
      //         ProfileStateHasData(
      //           Profile(
      //             userId: oldProfile?.userId ?? '',
      //             firstName: oldProfile?.firstName ?? '',
      //             lastName: oldProfile?.lastName ?? '',
      //             email: oldProfile?.email ?? '',
      //             accessToken: data.accessToken,
      //             refreshToken: data.refreshToken,
      //           ),
      //         ),
      //       );

      //       secureStorage.write(
      //           key: SecureStorageKeys.accessToken, value: data.accessToken);
      //       secureStorage.write(
      //           key: SecureStorageKeys.refreshToken, value: data.refreshToken);
      //     },
      //   );
      // },
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    on<OnEmptyState>(
      (event, emit) {
        emit(ProfileState.initial());
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    on<OnLogOut>(
      _onLogOut,
      // (event, emit) async {
      //   emit(ProfileStateLoading());
      //   final secureStorage = locator.get<FlutterSecureStorage>();

      //   await secureStorage.deleteAll();

      //   emit(ProfileStateEmpty());
      // },
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    // @override
    // void onChange(Change<ProfileState> change) {
    //   super.onChange(change);
    //   print(change);
    // }

    // @override
    // void onTransition(Transition<AuthEvent, ProfileState> transition) {
    //   super.onTransition(transition);
    //   print(transition);
    // }
  }

  Future<void> _onSignIn(OnSignIn event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: () => ProfileStateStatus.loading));
    final email = event.email;
    final password = event.password;
    final secureStorage = locator.get<FlutterSecureStorage>();

    final result = await _auth.signIn(
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        print('failure: ${failure.message}');
        emit(state.copyWith(
          status: () => ProfileStateStatus.failure,
          errorMessage: () => failure.message,
        ));
      },
      (data) {
        // emit(ProfileStateHasData(data));

        emit(state.copyWith(
          status: () => ProfileStateStatus.success,
          profile: () => data,
        ));

        secureStorage.write(
            key: SecureStorageKeys.accessToken, value: data.accessToken);
        secureStorage.write(
            key: SecureStorageKeys.refreshToken, value: data.refreshToken);
      },
    );
  }

  Future<void> _onSignUp(OnSignUp event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: () => ProfileStateStatus.loading));

    final firstName = event.firstName;
    final lastName = event.lastName;
    final email = event.email;
    final password = event.password;
    final secureStorage = locator.get<FlutterSecureStorage>();

    final result = await _auth.signUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        print('failure: ${failure.message}');
        // emit(ProfileStateError(failure.message));
        emit(state.copyWith(
          status: () => ProfileStateStatus.failure,
          errorMessage: () => failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          status: () => ProfileStateStatus.success,
          profile: () => data,
        )
            // ProfileStateHasData(data)
            );

        secureStorage.write(
            key: SecureStorageKeys.accessToken, value: data.accessToken);
        secureStorage.write(
            key: SecureStorageKeys.refreshToken, value: data.refreshToken);
      },
    );
  }

  Future<void> _onGetUser(OnGetUser event, Emitter<ProfileState> emit) async {
    Profile? oldProfile;
    if (state.status == ProfileStateStatus.success
        // state is ProfileStateHasData
        ) {
      oldProfile = state.getProfile;
    }

    emit(state.copyWith(status: () => ProfileStateStatus.loading));
    final result = await _auth.getUser();

    result.fold(
      (failure) {
        print('failure: ${failure.message}');
        // emit(ProfileStateError(failure.message));

        emit(state.copyWith(
          status: () => ProfileStateStatus.failure,
          errorMessage: () => failure.message,
        ));
      },
      (data) {
        emit(
          state.copyWith(
            status: () => ProfileStateStatus.success,
            profile: () => Profile(
              email: data.email,
              firstName: data.firstName,
              lastName: data.lastName,
              userId: data.userId,
              accessToken: oldProfile?.accessToken ?? '',
              refreshToken: oldProfile?.refreshToken ?? '',
            ),
          ),
        );
      },
    );
  }

  Future<void> _onSetTokens(
      OnSetTokens event, Emitter<ProfileState> emit) async {
    final accessToken = event.accessToken;
    final refreshToken = event.refreshToken;

    emit(
      state.copyWith(
        status: () => ProfileStateStatus.success,
        profile: () => Profile(
          userId: '',
          firstName: '',
          lastName: '',
          email: '',
          accessToken: accessToken,
          refreshToken: refreshToken,
        ),
      ),
    );
  }

  Future<void> _onRefreshToken(
      OnRefreshToken event, Emitter<ProfileState> emit) async {
    Profile? oldProfile;
    if (
        // state is ProfileStateHasData
        state.status == ProfileStateStatus.success) {
      oldProfile = state.getProfile;
    }

    emit(state.copyWith(status: () => ProfileStateStatus.loading));

    final refreshToken = event.refreshToken;
    final secureStorage = locator.get<FlutterSecureStorage>();

    final result = await _auth.refreshToken(refreshToken: refreshToken);

    result.fold(
      (failure) {
        print('failure: ${failure.message}');
        // emit(ProfileStateError(failure.message));

        emit(state.copyWith(
          status: () => ProfileStateStatus.failure,
          errorMessage: () => failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          status: () => ProfileStateStatus.success,
          profile: () => Profile(
            userId: oldProfile?.userId ?? '',
            firstName: oldProfile?.firstName ?? '',
            lastName: oldProfile?.lastName ?? '',
            email: oldProfile?.email ?? '',
            accessToken: data.accessToken,
            refreshToken: data.refreshToken,
          ),
        ));

        secureStorage.write(
            key: SecureStorageKeys.accessToken, value: data.accessToken);
        secureStorage.write(
            key: SecureStorageKeys.refreshToken, value: data.refreshToken);
      },
    );
  }

  Future<void> _onLogOut(OnLogOut event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: () => ProfileStateStatus.loading));
    final secureStorage = locator.get<FlutterSecureStorage>();

    await secureStorage.deleteAll();

    emit(ProfileState.initial());
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
