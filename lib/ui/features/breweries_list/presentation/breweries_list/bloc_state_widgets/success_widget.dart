import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_challenge/core/navigation/app_pages.dart';
import 'package:tech_challenge/core/widgets/beer_loader.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_entity.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/breweries_list/breweries_list_bloc.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/breweries_list/brewery_list_event.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/breweries_list/local_widgets/brewery_card.dart';

class SuccessWidget extends StatefulWidget {
  const SuccessWidget({
    super.key,
    required this.breweries,
    required this.isLoadingMore,
    required this.canLoadMore,
    required this.paginationError,
  });
  final List<Brewery> breweries;
  final bool isLoadingMore;
  final bool canLoadMore;
  final bool paginationError;
  @override
  State<SuccessWidget> createState() => _SuccessWidgetState();
}

class _SuccessWidgetState extends State<SuccessWidget> {
  late final ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasBottomItem = widget.isLoadingMore || widget.paginationError == true;
    final extraItem = hasBottomItem ? 1 : 0;
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.breweries.length + extraItem,
        itemBuilder: ((context, index) {
          if (index >= widget.breweries.length) {
            if (widget.paginationError == true) {
              return Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                  children: [
                    const Text('Error loading next page'),
                    const SizedBox(height: 8),
                    FilledButton.icon(
                      onPressed: () {
                        context.read<BreweriesListBloc>().add(const BreweryNextPageRequested());
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return const Padding(
              padding: EdgeInsets.all(12),
              child: Center(child: BeerLoader()),
            );
          }
          final brewery = widget.breweries[index];
          return BreweryCard(
            brewery: brewery,
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => AppPages.breweryDetail(breweryId: brewery.id)));
            },
          );
        }),
      ),
    );
  }

  void _onScroll() {
    if (!widget.canLoadMore ||
        !_scrollController.hasClients ||
        widget.isLoadingMore ||
        widget.paginationError == true) {
      return;
    }

    final position = _scrollController.position;
    const threshold = 200;

    final isNearBottom = position.pixels >= position.maxScrollExtent - threshold;

    if (isNearBottom) {
      context.read<BreweriesListBloc>().add(const BreweryNextPageRequested());
    }
  }
}
