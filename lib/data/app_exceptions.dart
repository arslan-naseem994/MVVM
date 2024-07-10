class AppExceptions implements Exception {
  final _message;
  final _prefix;
  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataExceptions extends AppExceptions {
  FetchDataExceptions([String? message])
      : super(message, 'Error During Communications');
}

class BadRequestExceptions extends AppExceptions {
  BadRequestExceptions([String? message]) : super(message, 'invalid request');
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String? message])
      : super(message, 'Unauthorized request');
}

class InvalidInputExcepiton extends AppExceptions {
  InvalidInputExcepiton([String? message]) : super(message, 'Invalid Input');
}
