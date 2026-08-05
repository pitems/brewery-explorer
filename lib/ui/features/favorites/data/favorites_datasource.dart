import 'package:tech_challenge/ui/features/favorites/domain/favorites_entity.dart';

abstract class FavoritesLocalDataSource {
  const FavoritesLocalDataSource();

  List<FavoriteEntity> getFavorites();

  Future<bool> saveFavorite(String breweryId);

  Future<bool> removeFavorite(String breweryId);
}
