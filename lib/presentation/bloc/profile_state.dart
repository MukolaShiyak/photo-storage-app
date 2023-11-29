import '/domain/entities/profile_entity.dart';

import 'package:equatable/equatable.dart';

// abstract class ProfileState extends Equatable {
//   const ProfileState();

//   @override
//   List<Object?> get props => [];

//   Profile get getProfile =>
//       const Profile(email: '', firstName: '', lastName: '', userId: '');
// }

// class ProfileStateEmpty extends ProfileState {}

// class ProfileStateLoading extends ProfileState {}

// class ProfileStateError extends ProfileState {
//   final String message;

//   const ProfileStateError(this.message);

//   @override
//   List<Object?> get props => [message];
// }

// class ProfileStateHasData extends ProfileState {
//   final Profile profile;

//   const ProfileStateHasData(this.profile);

//   @override
//   List<Object?> get props => [profile];

//   @override
//   Profile get getProfile => profile;
// }

enum ProfileStateStatus { initial, loading, success, failure }

final class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStateStatus.initial,
    this.errorMessage = '',
    this.profile,
  });

  final ProfileStateStatus status;
  final String errorMessage;
  final Profile? profile;

  ProfileState copyWith({
    ProfileStateStatus Function()? status,
    String Function()? errorMessage,
    Profile Function()? profile,
  }) {
    return ProfileState(
      status: status != null ? status() : this.status,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      profile: profile != null ? profile() : this.profile,
    );
  }

  factory ProfileState.initial() {
    return const ProfileState(
      status: ProfileStateStatus.initial,
      errorMessage: '',
      profile: null,
    );
  }

  Profile? get getProfile => profile;

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        profile,
      ];
}
