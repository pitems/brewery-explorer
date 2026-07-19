import 'package:flutter/material.dart';
import 'package:tech_challenge/core/di/injection.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_repository.dart';

class BreweriesListView extends StatelessWidget {
  BreweriesListView({super.key});
  final BreweryRepository repository = getIt<BreweryRepository>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(child: Text('Le data')),
        ElevatedButton(
          onPressed: () async {
            final breweries = await repository.getBreweries(page: 1, perPage: 20);

            print(breweries.first.name + '' + breweries.first.city);
          },
          child: Text("Get Data"),
        ),
      ],
    );
  }
}
