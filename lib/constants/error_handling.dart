import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/helpers/api_result.dart';
import 'package:flutter_shop_app/widgets/snackbar_utils.dart';
import 'package:http/http.dart' as http;

void httpErrorHandler({
  required BuildContext context,
  required http.Response response,
  required VoidCallback onSuccess,
}) {
  final ApiResult apiResult = ApiResult.fromError(jsonDecode(response.body));
  if (apiResult.isSuccessful) {
    onSuccess();
  } else {
    showSnackBarError(context, apiResult.message);
  }
}
