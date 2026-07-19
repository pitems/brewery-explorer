import 'package:tech_challenge/core/either/app_exception.dart';

class ParseException
    extends AppException {

    const ParseException()
        : super(
            'Unable to parse server response.',
        );

}
