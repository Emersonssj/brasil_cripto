import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/adapters/coin_hive_entity.dart';
import '../../../../core/services/hive/hive_service.dart';
import '../../../coin_search/domain/entities/coin_entity.dart';
import 'favorite_coins_event.dart';
import 'favorite_coins_state.dart';

class FavoriteCoinsBloc extends Bloc<FavoriteCoinsEvent, FavoriteCoinsState> {
  final HiveService hiveService;

  FavoriteCoinsBloc(this.hiveService) : super(FavoriteCoinsInitialState()) {
    on<LoadFavoritesCoins>(_onLoadFavorites);
    on<AddToFavoriteCoinsEvent>(_onAddCoinToFavorites);
    on<RemoveFromFavoriteCoinsEvent>(_onRemoveCoinFromFavorites);
  }

  void _onLoadFavorites(LoadFavoritesCoins event, Emitter emit) async {
    try {
      emit(FavoriteCoinsLoadingState());
      final favoriteCoins = hiveService.getAllCoins();
      emit(
        FavoriteCoinsLoadedState(
          favoriteCoins
              .map(
                (coin) => CoinEntity(
                  id: coin.id,
                  name: coin.name,
                  apiSymbol: coin.apiSymbol,
                  symbol: coin.symbol,
                  marketCapRank: coin.marketCapRank,
                  thumb: coin.thumb,
                  large: coin.large,
                ),
              )
              .toList(),
        ),
      );
    } catch (e) {
      emit(FavoriteCoinsErrorState('Erro ao carregar favoritos'));
    }
  }

  void _onAddCoinToFavorites(AddToFavoriteCoinsEvent event, Emitter emit) async {
    hiveService.addCoin(
      CoinHiveEntity(
        id: event.coin.id,
        name: event.coin.name,
        apiSymbol: event.coin.apiSymbol,
        symbol: event.coin.symbol,
        marketCapRank: event.coin.marketCapRank,
        thumb: event.coin.thumb,
        large: event.coin.large,
      ),
    );
    if (state is FavoriteCoinsLoadedState) {
      final currentState = state as FavoriteCoinsLoadedState;
      final List<CoinEntity> currentCoins = currentState.coins;
      final updatedList = List<CoinEntity>.from(currentCoins)..add(event.coin);

      emit(FavoriteCoinsLoadedState(updatedList));
    }
  }

  void _onRemoveCoinFromFavorites(RemoveFromFavoriteCoinsEvent event, Emitter emit) async {
    await hiveService.removeCoin(event.id);

    if (state is FavoriteCoinsLoadedState) {
      final currentState = state as FavoriteCoinsLoadedState;
      final updatedList = currentState.coins.where((coin) => coin.id != event.id).toList();

      emit(FavoriteCoinsLoadedState(updatedList));
    }
  }
}
