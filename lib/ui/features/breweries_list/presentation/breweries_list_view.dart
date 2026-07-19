import 'package:flutter/material.dart';
import 'package:tech_challenge/core/network/dio_client.dart';
import 'package:tech_challenge/ui/features/breweries_list/data/brewery_remote_datasource_impl.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_repository_impl.dart';

class BreweriesListView extends StatelessWidget {
  BreweriesListView({super.key});
  final repository = BreweryRepositoryImpl(remoteDatasource: BreweryRemoteDatasourceImpl(dioClient: DioClient()));
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(child: Text('Le data')),
        ElevatedButton(
          onPressed: () async {
            final breweries = await repository.getBreweries(page: 1, perPage: 20);

            print(breweries.first.name);
          },
          child: Text("Get Data"),
        ),
      ],
    );
  }
}
