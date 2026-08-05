sealed class FavoritesEvent {
  const FavoritesEvent();
}

final class LoadFavoritesRequested extends FavoritesEvent {
  const LoadFavoritesRequested();
}

final class ToggleFavoriteRequested extends FavoritesEvent {
  final String breweryId;

  const ToggleFavoriteRequested({required this.breweryId});
}

final class RemoveFavoriteRequested extends FavoritesEvent {
  final String breweryId;

  const RemoveFavoriteRequested({required this.breweryId});
}
