import 'dart:convert';

import 'package:flutter/foundation.dart';

Future<void> main(List<String> args) async {
  getClaims(String token) {
    if (token.isNotEmpty) {
      final parts = token.split('.');
      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final resp = utf8.decode(base64.decode(normalized));
      final payloadMap = json.decode(resp);
      return payloadMap;
    }
  }

  final claims = getClaims("");
  // iterate to print the claims
  claims.forEach((key, value) {
    if (kDebugMode) {
      print('$key: $value');
    }
  });

  if (claims['name'] == 'Developer' &&
      claims['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'] ==
          'SystemAdministrator') {
    if (kDebugMode) {
      print('Welcome Developer ${claims['name']}!');
    }
  } else {
    if (kDebugMode) {
      print('You are not authorized to access this resource');
    }
  }
}
