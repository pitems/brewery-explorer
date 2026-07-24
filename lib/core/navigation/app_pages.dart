import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_challenge/core/di/injection.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/breweries_list/breweries_list_bloc.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/breweries_list/breweries_list_view.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/breweries_list/brewery_list_event.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/brewery_detail/brewery_detail_bloc.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/brewery_detail/brewery_detail_event.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/brewery_detail/brewery_detail_view.dart';

abstract final class AppPages {
  static Widget breweriesList() {
    return BlocProvider(
      create: (_) => getIt<BreweriesListBloc>()..add(const BreweryListRequested()),
      child: BreweriesListView(),
    );
  }

  static Widget breweryDetail({required String breweryId}) {
    return BlocProvider(
      create: (_) => getIt<BreweryDetailBloc>()..add(BreweryDetailRequested(id: breweryId)),
      child: BreweryDetailView(breweryId: breweryId),
    );
  }
}
