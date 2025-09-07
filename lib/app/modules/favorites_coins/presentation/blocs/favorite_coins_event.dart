import '../../../coin_search/domain/entities/coin_entity.dart';

abstract class FavoriteCoinsEvent {
  const FavoriteCoinsEvent();
}

class LoadFavoritesCoins extends FavoriteCoinsEvent {}

class AddToFavoriteCoinsEvent extends FavoriteCoinsEvent {
  const AddToFavoriteCoinsEvent(this.coin);

  final CoinEntity coin;
}

class RemoveFromFavoriteCoinsEvent extends FavoriteCoinsEvent {
  const RemoveFromFavoriteCoinsEvent(this.id);

  final String id;
}
