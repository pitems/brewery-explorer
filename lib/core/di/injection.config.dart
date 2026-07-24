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
import 'package:tech_challenge/core/errors/app_error_mapper.dart' as _i761;
import 'package:tech_challenge/core/network/dio_client.dart' as _i30;
import 'package:tech_challenge/ui/features/brewery_explorer/data/brewery_remote_datasource.dart'
    as _i256;
import 'package:tech_challenge/ui/features/brewery_explorer/data/brewery_remote_datasource_impl.dart'
    as _i152;
import 'package:tech_challenge/ui/features/brewery_explorer/domain/brewery_repository.dart'
    as _i89;
import 'package:tech_challenge/ui/features/brewery_explorer/domain/brewery_repository_impl.dart'
    as _i1067;
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/breweries_list/breweries_list_bloc.dart'
    as _i754;
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/brewery_detail/brewery_detail_bloc.dart'
    as _i143;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i30.DioClient>(() => _i30.DioClient());
    gh.lazySingleton<_i256.BreweryRemoteDatasource>(
      () => _i152.BreweryRemoteDatasourceImpl(dioClient: gh<_i30.DioClient>()),
    );
    gh.lazySingleton<_i761.AppErrorMapper>(
      () => const _i761.AppErrorMapperImpl(),
    );
    gh.lazySingleton<_i89.BreweryRepository>(
      () => _i1067.BreweryRepositoryImpl(
        remoteDatasource: gh<_i256.BreweryRemoteDatasource>(),
      ),
    );
    gh.factory<_i754.BreweriesListBloc>(
      () => _i754.BreweriesListBloc(
        repository: gh<_i89.BreweryRepository>(),
        errorMapper: gh<_i761.AppErrorMapper>(),
      ),
    );
    gh.factory<_i143.BreweryDetailBloc>(
      () => _i143.BreweryDetailBloc(
        repository: gh<_i89.BreweryRepository>(),
        errorMapper: gh<_i761.AppErrorMapper>(),
      ),
    );
    return this;
  }
}
