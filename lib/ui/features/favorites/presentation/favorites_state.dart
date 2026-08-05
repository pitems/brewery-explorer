import 'package:tech_challenge/ui/features/favorites/domain/favorites_entity.dart';

sealed class FavoritesState {
  const FavoritesState();
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

class FavoritesLoaded extends FavoritesState {
  final List<FavoriteEntity> favorites;

  const FavoritesLoaded({required this.favorites});
}

class FavoritesFailure extends FavoritesState {
  final String message;

  const FavoritesFailure({required this.message});
}
