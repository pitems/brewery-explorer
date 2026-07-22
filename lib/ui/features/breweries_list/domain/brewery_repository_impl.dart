import 'package:injectable/injectable.dart';
import 'package:tech_challenge/ui/features/breweries_list/data/brewery_remote_datasource.dart';
import 'package:tech_challenge/ui/features/breweries_list/data/mapper/brewery_mapper.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_detail_entity.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_entity.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_repository.dart';

@LazySingleton(as: BreweryRepository)
class BreweryRepositoryImpl implements BreweryRepository {
  final BreweryRemoteDatasource remoteDatasource;

  BreweryRepositoryImpl({required this.remoteDatasource});
  @override
  Future<List<Brewery>> getBreweries({required int page, required int perPage}) async {
    final breweries = await remoteDatasource.getBreweries(page: page, perPage: perPage);
    return breweries.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<BreweryDetail> getBrewery(String id) async {
    final brewery = await remoteDatasource.getBrewery(id);
    return brewery.toDetailEntity();
  }

  @override
  Future<List<Brewery>> searchBreweries({required String query, required int page, required int perPage}) async {
    final breweries = await remoteDatasource.searchBreweries(query: query, page: page, perPage: perPage);
    return breweries.map((dto) => dto.toEntity()).toList();
  }
}
