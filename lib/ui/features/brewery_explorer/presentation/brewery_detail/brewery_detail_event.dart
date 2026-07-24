sealed class BreweryDetailEvent {
  const BreweryDetailEvent();
}

final class BreweryDetailRequested extends BreweryDetailEvent {
  BreweryDetailRequested({required this.id});
  final String id;
}
