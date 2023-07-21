import 'package:flutter/material.dart';
import 'package:flutter_shop_app/helpers/authentication.dart';
import 'package:flutter_shop_app/models/userwithtoken.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  final Logger logger = Logger();

  UserWithToken _user = UserWithToken(
    accessToken: "",
    refreshToken: "",
  );

  UserWithToken get userWithToken => _user;

  void setUserWithToken(UserWithToken userWithToken) {
    _user = UserWithToken.fromJson(userWithToken.toJson());
    notifyListeners();
  }

  Map<String, dynamic> _claims = {};

  Map<String, dynamic> get claims => _claims;

  Future<Map<String, dynamic>> getUserClaims() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    if (token != null) {
      _claims = Authentication.getClaims(token);
      notifyListeners();
      return _claims;
    }
    return {};
  }

  clearAndLogout() {
    // Clear all shared preferences
    SharedPreferences.getInstance().then((prefs) async {
      // Remove tokens
      await prefs.remove('access_token');
      await prefs.remove('refresh_token');
    });

    _user = UserWithToken(accessToken: "", refreshToken: "");
    _claims.clear();
    notifyListeners();
    logger.i("user logged out");
  }
}
