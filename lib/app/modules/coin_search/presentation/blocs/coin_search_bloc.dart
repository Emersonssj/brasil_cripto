import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/repositories/coin_search_repository.dart';
import 'coin_search_event.dart';
import 'coin_search_state.dart';

class CoinSearchBloc extends Bloc<CoinSearchEvent, CoinSearchState> {
  final CoinSearchRepository _repository;

  CoinSearchBloc(this._repository) : super(CoinSearchInitialState()) {
    on<GetCoinsEvent>(_getCoins, transformer: debounce(const Duration(milliseconds: 500)));
    on<ClearListEvent>(_onClearList);
  }

  Future<void> _getCoins(GetCoinsEvent event, Emitter emit) async {
    emit(CoinSearchLoadingState());

    final result = await _repository.getCoins(event.query);

    emit(result.fold((success) => GetCoinsSuccessState(coins: success), (failure) => GetCoinsErrorState()));
  }

  Future<void> _onClearList(ClearListEvent event, Emitter<CoinSearchState> emit) async {
    emit(CoinSearchInitialState());
  }
}

EventTransformer<E> debounce<E>(Duration duration) {
  return (events, mapper) {
    return events.debounceTime(duration).asyncExpand(mapper);
  };
}
