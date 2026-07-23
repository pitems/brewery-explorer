import 'package:tech_challenge/core/errors/app_exception.dart';

class FetchException
    extends AppException {

    const FetchException()
        : super(
            'Unable to fetch breweries.',
        );

}
