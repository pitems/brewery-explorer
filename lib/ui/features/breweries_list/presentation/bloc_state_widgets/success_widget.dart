import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_entity.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/breweries_list_bloc.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/brewery_list_event.dart';

class SuccessWidget extends StatefulWidget {
  const SuccessWidget({
    super.key,
    required this.breweries,
    required this.isLoadingMore,
    required this.canLoadMore,
  });
  final List<Brewery> breweries;
  final bool isLoadingMore;
  final bool canLoadMore;
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
    final extraItem = widget.isLoadingMore ? 1 : 0;

    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.breweries.length + extraItem,
        itemBuilder: ((context, index) {
          if (index >= widget.breweries.length) {
            return const Padding(
              padding: EdgeInsets.all(12),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final brewery = widget.breweries[index];
          return ListTile(
            title: Text(brewery.name),
            subtitle: Text(brewery.city),
          );
        }),
      ),
    );
  }

  void _onScroll() {
    if (!widget.canLoadMore ||
        !_scrollController.hasClients ||
        widget.isLoadingMore) {
      return;
    }

    final position = _scrollController.position;
    const threshold = 200;

    final isNearBottom =
        position.pixels >= position.maxScrollExtent - threshold;

    if (isNearBottom) {
      context.read<BreweriesListBloc>().add(const BreweryNextPageRequested());
    }
  }
}
