import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_detail_entity.dart';

sealed class BreweryDetailState {
  const BreweryDetailState();
}

final class BreweryDetailInitial extends BreweryDetailState {
  const BreweryDetailInitial();
}

final class BreweryDetailLoading extends BreweryDetailState {
  const BreweryDetailLoading();
}

final class BreweryDetailSuccess extends BreweryDetailState {
  BreweryDetailSuccess({required this.brewery});

  final BreweryDetail brewery;
}

final class BreweryDetailFailure extends BreweryDetailState {
  BreweryDetailFailure({required this.message});
  final String message;
}
