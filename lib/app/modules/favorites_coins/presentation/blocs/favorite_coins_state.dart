import '../../../coin_search/domain/entities/coin_entity.dart';

abstract class FavoriteCoinsState {}

class FavoriteCoinsInitialState extends FavoriteCoinsState {}

class FavoriteCoinsLoadingState extends FavoriteCoinsState {}

class FavoriteCoinsLoadedState extends FavoriteCoinsState {
  FavoriteCoinsLoadedState(this.coins);

  final List<CoinEntity> coins;
}

class FavoriteCoinsErrorState extends FavoriteCoinsState {
  FavoriteCoinsErrorState(this.message);

  final String message;
}
