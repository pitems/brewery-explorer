import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/brewery_detail/bloc_state_widgets/export.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/brewery_detail/brewery_detail_bloc.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/brewery_detail/brewery_detail_event.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/brewery_detail/brewery_detail_state.dart';

class BreweryDetailView extends StatelessWidget {
  const BreweryDetailView({super.key, required this.breweryId});
  final String breweryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Brewery detail')),
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<BreweryDetailBloc, BreweryDetailState>(
              builder: (context, state) {
                return switch (state) {
                  BreweryDetailInitial() || BreweryDetailLoading() => Expanded(child: const LoadingWidget()),
                  BreweryDetailFailure(:final message) => Expanded(
                    child: FailureWidget(
                      message: message,
                      onRetry: () {
                        context.read<BreweryDetailBloc>().add(BreweryDetailRequested(id: breweryId));
                      },
                    ),
                  ),
                  BreweryDetailSuccess(:final brewery) => Expanded(child: SuccessDetail(brewery: brewery)),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
