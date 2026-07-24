import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/breweries_list/breweries_list_bloc.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/breweries_list/brewery_list_event.dart';

class BrewerySearchBar extends StatefulWidget {
  const BrewerySearchBar({super.key});

  @override
  State<BrewerySearchBar> createState() => _BrewerySearchBarState();
}

class _BrewerySearchBarState extends State<BrewerySearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void clearSearch() {
    _controller.clear();
    context.read<BreweriesListBloc>().add(const BrewerySearchChanged(''));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'Search breweries',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          tooltip: 'Clear search ',
          onPressed: () {
            FocusScope.of(context).unfocus();
            clearSearch();
          },
          icon: const Icon(Icons.clear),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: (query) {
        context.read<BreweriesListBloc>().add(BrewerySearchChanged(query));
      },
    );
  }
}
