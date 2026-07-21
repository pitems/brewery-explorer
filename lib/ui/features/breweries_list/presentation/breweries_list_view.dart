import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_challenge/core/di/injection.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/bloc_state_widgets/success_widget.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/breweries_list_bloc.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/breweries_list_state.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/brewery_list_event.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/local_widgets/brewery_search_bar.dart';

class BreweriesListView extends StatelessWidget {
  const BreweriesListView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //Creates blocs and call list requested
      create: (_) =>
          getIt<BreweriesListBloc>()..add(const BreweryListRequested()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(12), child: BrewerySearchBar()),

              BlocBuilder<BreweriesListBloc, BreweriesListState>(
                builder: (context, state) {
                  return switch (state) {
                    BreweryListInitial() || BreweryListLoading() =>
                      const Center(child: CircularProgressIndicator()),
                    BreweryListEmpty() => const Center(
                      child: Text('No breweries found'),
                    ),
                    BreweryListFailure(:final message) => Center(
                      child: Text(message),
                    ),
                    BreweryListSuccess(
                      :final breweries,
                      :final isLoadingMore,
                      :final hasReachedEnd,
                      :final isSearchResult,
                    ) =>
                      SuccessWidget(
                        key: ValueKey(
                          isSearchResult ? 'search-result' : 'default-list',
                        ),
                        breweries: breweries,
                        isLoadingMore: isLoadingMore,
                        canLoadMore: !hasReachedEnd,
                      ),
                  };
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
