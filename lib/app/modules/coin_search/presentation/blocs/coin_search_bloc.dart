import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/coin_search_repository.dart';
import 'coin_search_event.dart';
import 'coin_search_state.dart';

class CoinSearchBloc extends Bloc<CoinSearchEvent, CoinSearchState> {
  final CoinSearchRepository _repository;

  CoinSearchBloc(this._repository) : super(CoinSearchInitialState()) {
    on<GetCoinsEvent>(_getCoins);
  }

  Future<void> _getCoins(GetCoinsEvent event, Emitter emit) async {
    emit(CoinSearchLoadingState());

    final result = await _repository.getCoins(event.query);

    emit(result.fold((success) => GetCoinsSuccessState(coins: success), (failure) => GetCoinsErrorState()));
  }
}
