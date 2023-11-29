import 'package:dartz/dartz.dart';

import '/data/failure.dart';
import '/domain/entities/token.dart';
import '/repositories/auth_repository.dart';
import '/domain/entities/profile_entity.dart';

class Auth {
  final AuthRepository repository;

  Auth(this.repository);

  Future<Either<Failure, Profile>> signIn({
    required String email,
    required String password,
  }) {
    return repository.signIn(
      email: email,
      password: password,
    );
  }

  Future<Either<Failure, Profile>> getUser() {
    return repository.getUser();
  }

  Future<Either<Failure, Profile>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) {
    return repository.signUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
  }

  Future<Either<Failure, Token>> refreshToken({required String refreshToken}) {
    return repository.refreshToken(refreshToken: refreshToken);
  }
}
