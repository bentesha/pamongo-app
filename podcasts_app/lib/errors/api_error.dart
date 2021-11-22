enum ApiErrorType { internet, timeout, unknown }

class ApiError extends Error {
  ApiError._({required this.type, required this.message});

  final String message;
  final ApiErrorType type;

  factory ApiError.fromType(ApiErrorType type) {
    switch (type) {
      case ApiErrorType.internet:
        return ApiError._(
            type: type,
            message: 'Please check your internet connection and try again.');
      case ApiErrorType.timeout:
        return ApiError._(
            type: type,
            message: 'Timeout was reached, Please try again later.');
      default:
        return ApiError._(
            type: type,
            message:
                'Request failed. You may want to check your internet connection.');
    }
  }
}
