import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../../domain/entities/trending_coin_entity.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class GetTrendingsSuccessState extends HomeState {
  GetTrendingsSuccessState({required this.coins});

  final List<TrendingCoinEntity> coins;
}

class GetTrendingsErrorState extends HomeState {
  GetTrendingsErrorState({required this.exception});

  final HttpRequestException exception;
}
