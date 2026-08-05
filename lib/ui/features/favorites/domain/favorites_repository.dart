import 'package:tech_challenge/ui/features/favorites/domain/favorites_entity.dart';

abstract class FavoritesRepository {
  const FavoritesRepository();

  Future<List<FavoriteEntity>> getFavorites();

  Future<bool> toggleFavorite(String breweryId);
}
