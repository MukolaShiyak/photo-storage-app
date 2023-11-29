import 'package:equatable/equatable.dart';

import '/domain/entities/profile_entity.dart';

class NoTokenProfileModel extends Equatable {
  const NoTokenProfileModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  final String userId;
  final String firstName;
  final String lastName;
  final String email;

  factory NoTokenProfileModel.fromJson(Map<String, dynamic> json) => NoTokenProfileModel(
        userId: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
      );

  Profile toEntity() => Profile(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        email: email,
      );

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
        email,
      ];
}
