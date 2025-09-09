import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/coin_details_repository.dart';
import 'coin_details_event.dart';
import 'coin_details_state.dart';

class CoinDetailsBloc extends Bloc<CoinDetailsEvent, CoinDetailsState> {
  final CoinDetailsRepository _repository;

  CoinDetailsBloc(this._repository) : super(CoinDetailsInitialState()) {
    on<GetCoinDetailsEvent>(_getCoinDetails);
  }

  Future<void> _getCoinDetails(GetCoinDetailsEvent event, Emitter emit) async {
    emit(CoinDetailsLoadingState());

    final result = await _repository.getCoinDetails(event.id);

    emit(
      result.fold(
        (success) => GetCoinDetailsSuccessState(coin: success),
        (failure) => GetCoinDetailsErrorState(exception: failure),
      ),
    );
  }
}
