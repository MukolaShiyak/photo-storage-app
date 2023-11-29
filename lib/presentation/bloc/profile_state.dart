import '/domain/entities/profile_entity.dart';

import 'package:equatable/equatable.dart';

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
