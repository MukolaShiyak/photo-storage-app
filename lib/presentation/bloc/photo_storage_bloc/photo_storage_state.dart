import '/domain/entities/profile_entity.dart';

import 'package:equatable/equatable.dart';

// abstract class PhotoStorageState extends Equatable {
//   const PhotoStorageState();

//   @override
//   List<Object?> get props => [];

//   Profile get getProfile =>
//       const Profile(email: '', firstName: '', lastName: '', userId: '');
// }

// class PhotoStorageStateEmpty extends PhotoStorageState {}

// class PhotoStorageStateLoading extends PhotoStorageState {}

// class PhotoStorageStateError extends PhotoStorageState {
//   final String message;

//   const PhotoStorageStateError(this.message);

//   @override
//   List<Object?> get props => [message];
// }

// class PhotoStorageStateHasData extends PhotoStorageState {
//   // final Profile profile;

//   // const PhotoStorageStateHasData(this.profile);

//   // @override
//   // List<Object?> get props => [profile];

//   // @override
//   // Profile get getProfile => profile;
// }

enum PhotoStorageStatus { initial, loading, success, failure }

final class PhotoStorageState extends Equatable {
  const PhotoStorageState({
    this.status = PhotoStorageStatus.initial,
    this.errorMessage = '',
    this.profile,
  });

  final PhotoStorageStatus status;
  final String errorMessage;
  final Profile? profile;

  PhotoStorageState copyWith({
    PhotoStorageStatus Function()? status,
    String Function()? errorMessage,
    Profile Function()? profile,
  }) {
    return PhotoStorageState(
      status: status != null ? status() : this.status,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      profile: profile != null ? profile() : this.profile,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        profile,
      ];
}
