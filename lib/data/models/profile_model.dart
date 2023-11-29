import 'package:equatable/equatable.dart';

import '/domain/entities/profile_entity.dart';

class ProfileModel extends Equatable {
  const ProfileModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.accessToken,
    this.refreshToken,
  });

  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String? accessToken;
  final String? refreshToken;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        userId: json['user']['id'],
        firstName: json['user']['firstName'],
        lastName: json['user']['lastName'],
        email: json['user']['email'],
        accessToken: json['token']['accessToken'],
        refreshToken: json['token']['refreshToken'],
      );

  Profile toEntity() => Profile(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
        email,
        accessToken,
        refreshToken,
      ];
}
