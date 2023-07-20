class ApiResult<T> {
  final bool isSuccessful;
  final T? result;
  final String message;

  ApiResult({
    required this.isSuccessful,
    required this.message,
    this.result,
  });

  factory ApiResult.fromSuccess(Map<String, dynamic> json) {
    return ApiResult(
      isSuccessful: true,
      message: json['message'],
    );
  }

  factory ApiResult.fromError(Map<String, dynamic> json) {
    return ApiResult(
      isSuccessful: false,
      message: json['message'],
    );
  }

  factory ApiResult.fromErrorString(String message) {
    return ApiResult(
      isSuccessful: false,
      message: message,
    );
  }
}
