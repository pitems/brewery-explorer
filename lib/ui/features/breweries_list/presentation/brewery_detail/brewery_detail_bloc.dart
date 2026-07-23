import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tech_challenge/core/errors/app_error_mapper.dart';
import 'package:tech_challenge/ui/features/breweries_list/domain/brewery_repository.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/brewery_detail/brewery_detail_event.dart';
import 'package:tech_challenge/ui/features/breweries_list/presentation/brewery_detail/brewery_detail_state.dart';

@injectable
class BreweryDetailBloc extends Bloc<BreweryDetailEvent, BreweryDetailState> {
  BreweryDetailBloc({required this.repository, required this.errorMapper}) : super(const BreweryDetailInitial()) {
    on<BreweryDetailRequested>(_onDetailRequested);
  }

  final BreweryRepository repository;
  final AppErrorMapper errorMapper;
  // Calls from the repository to get the data of the brewery selected
  Future<void> _onDetailRequested(BreweryDetailRequested event, Emitter<BreweryDetailState> emit) async {
    emit(BreweryDetailLoading());

    try {
      final brewery = await repository.getBrewery(event.id);

      emit(BreweryDetailSuccess(brewery: brewery));
    } catch (error) {
      emit(BreweryDetailFailure(message: errorMapper.map(error)));
    }
  }
}
