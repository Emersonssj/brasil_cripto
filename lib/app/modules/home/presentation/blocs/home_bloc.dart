import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/home_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _repository;

  HomeBloc(this._repository) : super(HomeInitialState()) {
    on<GetTrendingCoinsEvent>(_getTrendingCoins);
  }

  Future<void> _getTrendingCoins(GetTrendingCoinsEvent event, Emitter emit) async {
    emit(HomeLoadingState());

    final result = await _repository.getTrendingCoins();

    emit(
      result.fold(
        (success) => GetTrendingsSuccessState(coins: success),
        (failure) => GetTrendingsErrorState(exception: failure),
      ),
    );
  }
}
