import 'package:tech_challenge/core/errors/app_exception.dart';

class ParseException extends AppException {
  const ParseException()
    : super(
        'Unable to parse server response.',
      );
}
