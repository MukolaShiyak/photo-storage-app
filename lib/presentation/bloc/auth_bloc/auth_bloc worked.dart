// import 'package:rxdart/rxdart.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import '/injector.dart';
// import '/usecase/auth.dart';
// import '/data/secure_storage_keys.dart';
// import '/domain/entities/profile_entity.dart';
// import '/presentation/bloc/profile_state.dart';
// import '/presentation/bloc/auth_bloc/auth_event.dart';

// class AuthBloc extends Bloc<AuthEvent, ProfileState> {
//   final Auth _auth;

//   AuthBloc(
//     this._auth,
//   ) : super(ProfileState(
//             profile: const Profile(
//           userId: '',
//           firstName: '',
//           lastName: '',
//           email: '',
//         ))) {
//     on<OnSignIn>(
//       (event, emit) async {
//         final email = event.email;
//         final password = event.password;
//         final secureStorage = locator.get<FlutterSecureStorage>();

//         final result = await _auth.signIn(
//           email: email,
//           password: password,
//         );

//         result.fold(
//           (failure) {
//             print('failure: ${failure.message}');
//           },
//           (data) {
//             emit(state.copyWith(profile: data));

//             secureStorage.write(
//                 key: SecureStorageKeys.accessToken, value: data.accessToken);
//             secureStorage.write(
//                 key: SecureStorageKeys.refreshToken, value: data.refreshToken);
//           },
//         );
//       },
//       transformer: debounce(const Duration(milliseconds: 500)),
//     );

//     on<OnGetUser>(
//       (event, emit) async {
//         final result = await _auth.getUser();

//         result.fold(
//           (failure) {
//             print('failure: ${failure.message}');
//           },
//           (data) {
//             emit(state.copyWith(
//                 profile: Profile(
//               userId: data.userId,
//               firstName: data.firstName,
//               lastName: data.lastName,
//               email: data.email,
//               accessToken: state.profile.accessToken,
//               refreshToken: state.profile.refreshToken,
//             )));
//           },
//         );
//       },
//       transformer: debounce(const Duration(milliseconds: 500)),
//     );

//     on<OnSetTokens>(
//       (event, emit) async {
//         final accessToken = event.accessToken;
//         final refreshToken = event.refreshToken;

//         emit(state.copyWith(
//             profile: Profile(
//           userId: state.profile.userId,
//           firstName: state.profile.firstName,
//           lastName: state.profile.lastName,
//           email: state.profile.email,
//           accessToken: accessToken,
//           refreshToken: refreshToken,
//         )));
//       },
//       transformer: debounce(const Duration(milliseconds: 500)),
//     );

//     on<OnRefreshToken>(
//       (event, emit) async {
//         final refreshToken = event.refreshToken;
//         final secureStorage = locator.get<FlutterSecureStorage>();

//         final result = await _auth.refreshToken(refreshToken: refreshToken);

//         result.fold(
//           (failure) {
//             print('failure: ${failure.message}');
//           },
//           (data) {
//             emit(state.copyWith(
//                 profile: Profile(
//               userId: state.profile.userId,
//               firstName: state.profile.firstName,
//               lastName: state.profile.lastName,
//               email: state.profile.email,
//               accessToken: data.accessToken,
//               refreshToken: data.refreshToken,
//             )));

//             secureStorage.write(
//                 key: SecureStorageKeys.accessToken, value: data.accessToken);
//             secureStorage.write(
//                 key: SecureStorageKeys.refreshToken, value: data.refreshToken);
//           },
//         );
//       },
//       transformer: debounce(const Duration(milliseconds: 500)),
//     );
//   }

//   EventTransformer<T> debounce<T>(Duration duration) {
//     return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
//   }
// }
