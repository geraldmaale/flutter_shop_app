// import 'package:json_annotation/json_annotation.dart';

// part 'userwithtoken.g.dart';

// @JsonSerializable()
class UserWithToken {
  // final String? userId;
  // final String? fullName;
  // final String? userName;
  // final String? personId;
  final String accessToken;
  final String refreshToken;

  UserWithToken({
    required this.accessToken,
    required this.refreshToken,
    // this.userId,
    // this.fullName,
    // this.userName,
    // this.personId,
  });

  factory UserWithToken.fromJson(Map<String, dynamic> json) {
    return UserWithToken(
      accessToken: json['accessToken']!,
      refreshToken: json['refreshToken']!,
      // userId: json['userId'],
      // fullName: json['fullName'],
      // userName: json['userName'],
      // personId: json['personId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      // 'userId': userId!,
      // 'fullName': fullName!,
      // 'userName': userName!,
      // 'personId': personId!,
    };
  }
}
