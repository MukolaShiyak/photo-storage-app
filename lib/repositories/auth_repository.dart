import 'package:dartz/dartz.dart';

import '/data/failure.dart';
import '/domain/entities/token.dart';
import '/domain/entities/profile_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, Profile>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, Profile>> getUser();

  Future<Either<Failure, Profile>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<Either<Failure, Token>> refreshToken({required String refreshToken});
}
