import 'package:dio/dio.dart';
import 'package:flutter_shop_app/helpers/auth_models.dart';
import 'package:flutter_shop_app/helpers/constants.dart';
import 'package:flutter_shop_app/helpers/api_result.dart';
import 'package:logger/logger.dart';

class AuthEndpoints {
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
        Constants.registerUrl,
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

  Future<ApiResult> loginUser(String email, String password) async {
    var body = {
      'username': email,
      'password': password,
    };

    ApiResult apiResult;

    try {
      var response = await httpClient.post(
        Constants.loginUrl,
        data: body,
        options: Options(
          headers: {
            "ApiKey": "e454d028-ff79-4d7c-9548-94151a1d0b3d",
          },
        ),
      );

      var apiResult = ApiResult<UserWithToken>(
        isSuccessful: response.data['isSuccessful'],
        result: UserWithToken.fromJson(response.data['result']),
        message: response.data['message'],
      );

      logger.i(apiResult.message);
      return apiResult;
    } on DioException catch (e) {
      apiResult = ApiResult.fromError(e.response?.data);
      logger.e(apiResult.message);

      return apiResult;
    } catch (e) {
      logger.e(e.toString());

      return ApiResult(
          isSuccessful: false,
          message: "Sorry, something fatal occured, please try again");
    }
  }
}
