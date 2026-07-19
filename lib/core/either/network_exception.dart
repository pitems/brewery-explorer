import 'package:tech_challenge/core/either/app_exception.dart';

class NetworkException extends AppException {
  const NetworkException() : super('Network unavailable.');
}
