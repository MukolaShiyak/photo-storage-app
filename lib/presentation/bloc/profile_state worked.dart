import 'dart:convert' as cv;

import '/domain/entities/profile_entity.dart';

class ProfileState {
  final Profile profile;

  ProfileState({
    required this.profile,
  });

  ProfileState copyWith({
    Profile? profile,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profile': profile,
    };
  }

  factory ProfileState.fromMap(Map<String, dynamic> map) {
    return ProfileState(
      profile: map['profile'] as Profile,
    );
  }
  String toJson() => cv.json.encode(toMap());

  factory ProfileState.fromJson(String source) {
    return ProfileState.fromMap(cv.json.decode(source) as Map<String, dynamic>);
  }

  @override
  String toString() =>
      'ProfileState(firstName: ${profile.firstName}, lastName: ${profile.lastName}, email: ${profile.email}, userId: ${profile.userId},)';
}
