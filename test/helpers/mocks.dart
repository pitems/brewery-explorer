import 'package:mocktail/mocktail.dart';
import 'package:tech_challenge/core/either/app_error_mapper.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_repository.dart';

class MockBreweryRepository extends Mock implements BreweryRepository {}

class MockAppErrorMapper extends Mock implements AppErrorMapper {}
