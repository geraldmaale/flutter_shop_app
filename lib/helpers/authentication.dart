import 'dart:convert';

class Authentication {
  static _getClaims(String token) {
    if (token.isNotEmpty) {
      final parts = token.split('.');
      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final resp = utf8.decode(base64.decode(normalized));
      final payloadMap = json.decode(resp);
      return payloadMap;
    }
  }

  String? getUserName(String token) {
    final payloadMap = _getClaims(token);
    return payloadMap['preferred_username'];
  }

  String? getRole(String token) {
    final payloadMap = _getClaims(token);
    return payloadMap[
        'http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
  }

  String? getFullName(String token) {
    final payloadMap = _getClaims(token);
    return payloadMap[
        'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'];
  }

  String? getPersonId(String token) {
    final payloadMap = _getClaims(token);
    return payloadMap['person_id'];
  }

  String? getUserId(String token) {
    final payloadMap = _getClaims(token);
    return payloadMap['user_id'];
  }

  String? getAccessToken(String token) {
    final payloadMap = _getClaims(token);
    return payloadMap['access_token'];
  }

  String? getRefreshToken(String token) {
    final payloadMap = _getClaims(token);
    return payloadMap['refresh_token'];
  }

  String? getExpiresIn(String token) {
    final payloadMap = _getClaims(token);
    return payloadMap['expires_in'];
  }

  static Map<String, dynamic> getClaims(String token) {
    final payloadMap = _getClaims(token);
    return payloadMap;
  }
}
