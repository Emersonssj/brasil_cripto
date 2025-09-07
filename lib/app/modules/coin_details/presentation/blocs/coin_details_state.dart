import '../../domain/entities/coin_details_entity.dart';

abstract class CoinDetailsState {}

class CoinDetailsInitialState extends CoinDetailsState {}

class CoinDetailsLoadingState extends CoinDetailsState {}

class GetCoinDetailsSuccessState extends CoinDetailsState {
  GetCoinDetailsSuccessState({required this.coin});

  final CoinDetailsEntity coin;
}

class GetCoinDetailsErrorState extends CoinDetailsState {
  GetCoinDetailsErrorState();
}
