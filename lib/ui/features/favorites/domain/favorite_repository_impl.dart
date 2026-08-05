import 'package:injectable/injectable.dart';
import 'package:tech_challenge/ui/features/favorites/data/favorites_datasource.dart';
import 'package:tech_challenge/ui/features/favorites/domain/favorites_entity.dart';
import 'package:tech_challenge/ui/features/favorites/domain/favorites_repository.dart';

@LazySingleton(as: FavoritesRepository)
class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepositoryImpl({required this.localDataSource});
  @override
  Future<List<FavoriteEntity>> getFavorites() async {
    final favorites = localDataSource.getFavorites();
    return favorites;
  }

  @override
  Future<bool> toggleFavorite(String breweryId) async {
    final favorites = localDataSource.getFavorites();
    final alreadyFavorite = favorites.any((favorite) => favorite.breweryId == breweryId);

    if (alreadyFavorite) {
      await localDataSource.removeFavorite(breweryId);
      return false;
    }

    await localDataSource.saveFavorite(breweryId);
    return true;
  }
}
