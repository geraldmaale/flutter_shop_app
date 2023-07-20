import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constants/api_endpoints.dart';
import 'package:flutter_shop_app/helpers/api_result.dart';
import 'package:flutter_shop_app/helpers/authentication.dart';
import 'package:flutter_shop_app/models/loginrequest.dart';
import 'package:flutter_shop_app/models/userwithtoken.dart';
import 'package:flutter_shop_app/providers/user_provider.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final logger = Logger();
  final httpClient = Dio();

  Future<ApiResult> createUser(String userName, String fullName,
      String password, String confirmPassword) async {
    var body = {
      'userName': userName,
      'fullName': fullName,
      'password': password,
      'confirmPassword': confirmPassword,
    };

    ApiResult apiResult;

    try {
      var response = await httpClient.post(
        ApiEndpoints.registerUrl,
        data: body,
        options: Options(
          headers: {
            "ApiKey": "e454d028-ff79-4d7c-9548-94151a1d0b3d",
          },
        ),
      );

      var apiResult = ApiResult.fromSuccess(response.data);
      logger.i(apiResult.message);

      return apiResult;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        apiResult = ApiResult.fromError(e.response?.data);
        logger.e(apiResult.message);
        return apiResult;
      }
      logger.e(e.toString());
      return ApiResult(
          isSuccessful: false,
          message: "Could not register account, please again later.");
    } catch (e) {
      logger.e(e.toString());
      return ApiResult(
          isSuccessful: false,
          message: "Sorry, something fatal occured, please try again");
    }
  }

  Future<ApiResult> loginUser(
      BuildContext context, LoginRequest request) async {
    try {
      var response = await httpClient.post(
        ApiEndpoints.loginUrl,
        data: request.toJson(),
        options: Options(
          headers: {
            "ApiKey": "e454d028-ff79-4d7c-9548-94151a1d0b3d",
          },
        ),
      );

      var loginResponse = UserWithToken.fromJson(response.data["result"]);
      // Save token to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', loginResponse.accessToken);
      await prefs.setString('refresh_token', loginResponse.refreshToken);
      // await prefs.setString('user_id', loginResponse.userId);
      // await prefs.setString('person_id', loginResponse.personId);
      // await prefs.setString('full_name', loginResponse.fullName);
      // await prefs.setString('user_name', loginResponse.userName);

      // use provider to save user
      Provider.of<UserProvider>(context, listen: false)
          .setUserWithToken(loginResponse);

      logger.i(response.data["message"]);

      return ApiResult.fromSuccess(response.data);
    } on DioException catch (e) {
      return ApiResult.fromError(e.response?.data);
    } catch (e) {
      logger.e(e.toString());
      return ApiResult.fromErrorString(
          "Sorry, something fatal occured, please try again");
    }
  }

  Future<String> getUser(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accessToken = prefs.getString('access_token');
      var refreshToken = prefs.getString('refresh_token');
      // var userId = prefs.getString('user_id');
      // var personId = prefs.getString('person_id');
      // var fullName = prefs.getString('full_name');
      // var userName = prefs.getString('user_name');

      if (accessToken != null && refreshToken != null) {
        var userWithToken = UserWithToken(
          accessToken: accessToken,
          refreshToken: refreshToken,
          // userId: userId,
          // personId: personId,
          // fullName: fullName,
          // userName: userName,
        );

        Provider.of<UserProvider>(context, listen: false)
            .setUserWithToken(userWithToken);

        var claims = Authentication.getClaims(accessToken);
        Provider.of<UserProvider>(context, listen: false).setUserClaims(claims);

        logger.i("user token ", accessToken);

        return accessToken;
      }
    } catch (e) {
      logger.e(e.toString());
    }
    return Future.error("No user found");
    // return Future.error("No user found");
  }
}
