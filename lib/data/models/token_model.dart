import 'package:equatable/equatable.dart';

import '/domain/entities/token.dart';

class TokenModel extends Equatable {
  const TokenModel({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
      );

  Token toEntity() => Token(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
      ];
}
