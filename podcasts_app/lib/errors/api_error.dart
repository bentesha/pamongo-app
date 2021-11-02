enum ApiErrorType { internet, unknown }

class ApiError extends Error {
  ApiError({required this.type, required this.message});

  final String message;
  final ApiErrorType type;

  factory ApiError.fromType(ApiErrorType type) {
    return ApiError(
        type: type,
        message:
            'Request failed. You may want to check your internet connection.');
  }
}
