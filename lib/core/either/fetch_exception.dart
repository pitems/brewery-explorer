import 'package:tech_challenge/core/either/app_exception.dart';

class FetchException
    extends AppException {

    const FetchException()
        : super(
            'Unable to fetch breweries.',
        );

}
