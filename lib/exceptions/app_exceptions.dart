/// [AppException] is a custom exception which implements [Exception] abstract class
class AppException implements Exception {
  final String errorMessage;
  const AppException({required this.errorMessage});
}

/// [BadRequestException] is thrown for status code of 400
class BadRequestException extends AppException {
  BadRequestException({required super.errorMessage});
}

/// [InternalServerException] is thrown for status code 500
class InternalServerException extends AppException {
  InternalServerException({required super.errorMessage});
}

/// [NotFoundException] is thrown for status code 404
class NotFoundException extends AppException {
  NotFoundException({required super.errorMessage});
}

/// [ConflictException] is thrown for stauts code 409

class ConflictException extends AppException {
  ConflictException({required super.errorMessage});
}

/// [UnauthorizedException] is thrown for stauts code 401
class UnauthorizedException extends AppException {
  UnauthorizedException({required super.errorMessage});
}

/// [ResourceConflictException] is thrown for status code 409
class ResourceConflictException extends AppException {
  ResourceConflictException({required super.errorMessage});
}
