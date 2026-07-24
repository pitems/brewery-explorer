import 'package:mocktail/mocktail.dart';
import 'package:tech_challenge/core/errors/app_error_mapper.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/domain/brewery_repository.dart';

class MockBreweryRepository extends Mock implements BreweryRepository {}

class MockAppErrorMapper extends Mock implements AppErrorMapper {}
