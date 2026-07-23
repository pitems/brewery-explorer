import 'package:tech_challenge/core/errors/app_exception.dart';

class NetworkException extends AppException {
  const NetworkException() : super('Network unavailable.');
}
