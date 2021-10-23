enum ErrorType { internet, unknown, failedToBuffer }

class AudioError extends Error {
  AudioError({required this.type, required this.message});

  final String message;
  final ErrorType type;

  factory AudioError.fromErrorCode({int? errorCode}) {
    if (errorCode == 0) {
      return AudioError(
          type: ErrorType.internet,
          message: 'Please check your internet connection and try again.');
    } else {
      return AudioError(
          type: ErrorType.unknown,
          message: 'Oops! An error happened, Please try again later.');
    }
  }

  factory AudioError.fromType(ErrorType type) {
    return AudioError(
        type: type,
        message:
            'Failed to buffer, you might want  to check your internet connection');
  }
}
