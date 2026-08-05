import 'package:injectable/injectable.dart';
import 'package:tech_challenge/ui/features/favorites/data/favorites_datasource.dart';
import 'package:tech_challenge/ui/features/favorites/domain/favorites_entity.dart';

@LazySingleton(as: FavoritesLocalDataSource)
class InMemoryFavoritesDataSource implements FavoritesLocalDataSource {
  final List<FavoriteEntity> _favorites = [];
  @override
  List<FavoriteEntity> getFavorites() {
    return _favorites;
  }

  @override
  Future<bool> saveFavorite(String breweryId) async {
    final anyExist = _favorites.any((element) => element.breweryId == breweryId);

    if (!anyExist) {
      final newFavorite = FavoriteEntity(breweryId: breweryId, isFavorite: true);
      _favorites.add(newFavorite);
      return true;
    }
    return false;
  }

  @override
  Future<bool> removeFavorite(String breweryId) async {
    final index = _favorites.indexWhere((element) => element.breweryId == breweryId);

    if (index == -1) {
      return false;
    }

    _favorites.removeAt(index);
    return true;
  }
}
