sealed class BreweryListEvent {
  const BreweryListEvent();
}

final class BreweryListRequested extends BreweryListEvent {
  const BreweryListRequested();
}

final class BrewerySearchChanged extends BreweryListEvent {
  const BrewerySearchChanged(this.query);
  final String query;
}

final class BreweryNextPageRequested extends BreweryListEvent {
  const BreweryNextPageRequested();
}

final class BreweryListRetry extends BreweryListEvent {
  const BreweryListRetry();
}
