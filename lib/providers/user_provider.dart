import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/userwithtoken.dart';

class UserProvider extends ChangeNotifier {
  UserWithToken _user = UserWithToken(
    accessToken: "",
    refreshToken: "",
    // userId: "",
    // userName: "",
    // fullName: "",
    // personId: ""
  );

  UserWithToken get userWithToken => _user;

  void setUserWithToken(UserWithToken userWithToken) {
    _user = UserWithToken.fromJson(userWithToken.toJson());
    notifyListeners();
  }

  final Map<String, dynamic> _claims = {};

  Map<String, dynamic> get claims => _claims;

  void setUserClaims(Map<String, dynamic> claims) {
    _claims.clear();
    _claims.addAll(claims);
    notifyListeners();
  }

  void clearAndLogout() {
    _user = UserWithToken(accessToken: "", refreshToken: "");
    _claims.clear();
    notifyListeners();
  }
}
