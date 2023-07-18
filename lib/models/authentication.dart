class UserWithToken {
  String? userId;
  String? accessToken;
  String? refreshToken;
  String? fullName;
  String? userName;
  String? nextBillingDate;
  String? daysLeft;
  String? personId;

  UserWithToken({
    this.userId,
    this.accessToken,
    this.refreshToken,
    this.fullName,
    this.userName,
    this.nextBillingDate,
    this.daysLeft,
    this.personId,
  });

  factory UserWithToken.fromJson(Map<String, dynamic> json) {
    return UserWithToken(
      userId: json['userId'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      fullName: json['fullName'],
      userName: json['userName'],
      nextBillingDate: json['nextBillingDate'],
      daysLeft: json['daysLeft'],
      personId: json['personId'],
    );
  }
}
