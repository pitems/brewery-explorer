// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:tech_challenge/core/either/app_error_mapper.dart' as _i421;
import 'package:tech_challenge/core/network/dio_client.dart' as _i30;
import 'package:tech_challenge/ui/features/breweries_list/data/brewery_remote_datasource.dart'
    as _i252;
import 'package:tech_challenge/ui/features/breweries_list/data/brewery_remote_datasource_impl.dart'
    as _i60;
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_repository.dart'
    as _i640;
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_repository_impl.dart'
    as _i378;
import 'package:tech_challenge/ui/features/breweries_list/presentation/breweries_list_bloc.dart'
    as _i581;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i30.DioClient>(() => _i30.DioClient());
    gh.lazySingleton<_i252.BreweryRemoteDatasource>(
      () => _i60.BreweryRemoteDatasourceImpl(dioClient: gh<_i30.DioClient>()),
    );
    gh.lazySingleton<_i421.AppErrorMapper>(
      () => const _i421.AppErrorMapperImpl(),
    );
    gh.lazySingleton<_i640.BreweryRepository>(
      () => _i378.BreweryRepositoryImpl(
        remoteDatasource: gh<_i252.BreweryRemoteDatasource>(),
      ),
    );
    gh.factory<_i581.BreweriesListBloc>(
      () => _i581.BreweriesListBloc(
        repository: gh<_i640.BreweryRepository>(),
        errorMapper: gh<_i421.AppErrorMapper>(),
      ),
    );
    return this;
  }
}
