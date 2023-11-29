import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class OnSignIn extends AuthEvent {
  final String email;
  final String password;

  const OnSignIn({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [];
}

class OnGetUser extends AuthEvent {
  const OnGetUser();

  @override
  List<Object?> get props => [];
}

class OnSignUp extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  const OnSignUp({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [];
}

class OnSetTokens extends AuthEvent {
  final String accessToken;
  final String refreshToken;
  const OnSetTokens({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [];
}

class OnRefreshToken extends AuthEvent {
  final String refreshToken;
  const OnRefreshToken({
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [];
}

class OnEmptyState extends AuthEvent {
  const OnEmptyState();

  @override
  List<Object?> get props => [];
}

class OnLogOut extends AuthEvent {
  const OnLogOut();

  @override
  List<Object?> get props => [];
}
