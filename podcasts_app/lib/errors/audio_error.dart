enum ErrorType { internet, unknown, failedToBuffer }

class AudioError extends Error {
  AudioError._({required this.message});

  final String message;

  factory AudioError.fromType(ErrorType type) {
    switch (type) {
      case ErrorType.internet:
        return AudioError._(
            message:
                'There\'s a poor or no internet connection. Please try again later');
      case ErrorType.failedToBuffer:
        return AudioError._(
            message:
                'Failed to buffer, you might want  to check your internet connection.');
      default:
        return AudioError._(
            message: 'Oops! An error happened, Please try again later.');
    }
  }
}
