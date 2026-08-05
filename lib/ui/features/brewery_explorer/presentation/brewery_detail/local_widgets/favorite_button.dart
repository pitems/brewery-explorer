import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/domain/brewery_detail_entity.dart';
import 'package:tech_challenge/ui/features/favorites/presentation/favorites_bloc.dart';
import 'package:tech_challenge/ui/features/favorites/presentation/favorites_events.dart';
import 'package:tech_challenge/ui/features/favorites/presentation/favorites_state.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.brewery,
  });

  final BreweryDetail brewery;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoritesBloc, FavoritesState, bool>(
      selector: (state) {
        if (state is FavoritesLoaded) {
          return state.favorites.any(
            (favorite) => favorite.breweryId == brewery.id && favorite.isFavorite,
          );
        }
        return false;
      },
      builder: (context, isFavorite) {
        return IconButton(
          onPressed: () {
            context.read<FavoritesBloc>().add(
              ToggleFavoriteRequested(
                breweryId: brewery.id,
              ),
            );
          },
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border_outlined),
        );
      },
    );
  }
}
