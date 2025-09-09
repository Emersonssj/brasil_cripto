import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../../domain/entities/coin_entity.dart';

abstract class CoinSearchState {}

class CoinSearchInitialState extends CoinSearchState {}

class CoinSearchLoadingState extends CoinSearchState {}

class GetCoinsSuccessState extends CoinSearchState {
  GetCoinsSuccessState({required this.coins});

  final List<CoinEntity> coins;
}

class GetCoinsErrorState extends CoinSearchState {
  GetCoinsErrorState({required this.exception});

  final HttpRequestException exception;
}
