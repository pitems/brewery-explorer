import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tech_challenge/core/errors/app_error_mapper.dart';
import 'package:tech_challenge/ui/features/favorites/domain/favorites_repository.dart';
import 'package:tech_challenge/ui/features/favorites/presentation/favorites_events.dart';
import 'package:tech_challenge/ui/features/favorites/presentation/favorites_state.dart';

@injectable
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({required this.repository, required this.errorMapper}) : super(const FavoritesInitial()) {
    on<LoadFavoritesRequested>(_onLoadFavoritesRequested);
    on<ToggleFavoriteRequested>(_onToggleFavoriteRequested);
  }

  final FavoritesRepository repository;
  final AppErrorMapper errorMapper;

  Future<void> _onLoadFavoritesRequested(
    LoadFavoritesRequested event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesLoading());

    try {
      final favorites = await repository.getFavorites();
      emit(FavoritesLoaded(favorites: favorites));
    } catch (error) {
      emit(FavoritesFailure(message: errorMapper.map(error)));
    }
  }

  Future<void> _onToggleFavoriteRequested(
    ToggleFavoriteRequested event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await repository.toggleFavorite(event.breweryId);
      final favorites = await repository.getFavorites();
      emit(FavoritesLoaded(favorites: favorites));
    } catch (error) {
      emit(FavoritesFailure(message: errorMapper.map(error)));
    }
  }
}
