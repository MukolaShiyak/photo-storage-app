import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  const Profile({
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
