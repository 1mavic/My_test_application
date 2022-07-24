abstract class ApiError {
  String get error => "";
}

class RequestTimeOut extends ApiError {
  @override
  String get error => "Connection request timeout";
}

class SendTimeOut extends ApiError {
  @override
  String get error => "Send timeout in connection with server";
}

class InternalServerError extends ApiError {
  @override
  String get error => "Internal server error";
}

class NoInternetException extends ApiError {
  @override
  String get error => "No internet";
}

class UnExpectedException extends ApiError {
  @override
  String get error => "Unmkown error";
}
