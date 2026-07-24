import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_challenge/core/widgets/beer_loader.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/breweries_list/bloc_state_widgets/empty_widget.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/breweries_list/bloc_state_widgets/success_widget.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/breweries_list/breweries_list_bloc.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/breweries_list/breweries_list_state.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/breweries_list/brewery_list_event.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/breweries_list/local_widgets/brewery_search_bar.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/brewery_detail/bloc_state_widgets/export.dart';

class BreweriesListView extends StatelessWidget {
  const BreweriesListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(12), child: BrewerySearchBar()),

            BlocBuilder<BreweriesListBloc, BreweriesListState>(
              builder: (context, state) {
                return switch (state) {
                  BreweryListInitial() || BreweryListLoading() => const Center(child: BeerLoader()),
                  BreweryListEmpty() => Expanded(child: EmptyWidget()),
                  BreweryListFailure(:final message) => Expanded(
                    child: FailureWidget(
                      message: message,
                      onRetry: () {
                        context.read<BreweriesListBloc>().add(const BreweryListRetry());
                      },
                    ),
                  ),
                  BreweryListSuccess(
                    :final breweries,
                    :final isLoadingMore,
                    :final hasReachedEnd,
                    :final isSearchResult,
                    :final paginationError,
                  ) =>
                    SuccessWidget(
                      key: ValueKey(isSearchResult ? 'search-result' : 'default-list'),
                      breweries: breweries,
                      isLoadingMore: isLoadingMore,
                      canLoadMore: !hasReachedEnd,
                      paginationError: paginationError,
                    ),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
