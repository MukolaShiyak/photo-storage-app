import '/domain/entities/profile_entity.dart';

import 'package:equatable/equatable.dart';

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
