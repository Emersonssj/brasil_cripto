import '../../../../../core/services/http/exceptions/http_request_exception.dart';
import '../../../domain/entities/market_chart_entity.dart';

abstract class ValuesChartState {}

class ValuesChartInitialState extends ValuesChartState {}

class ValuesChartLoadingState extends ValuesChartState {}

class GetChartInfoSuccessState extends ValuesChartState {
  GetChartInfoSuccessState({required this.marketChart});

  final MarketChartEntity marketChart;
}

class GetChartInfoErrorState extends ValuesChartState {
  GetChartInfoErrorState({required this.exception});

  final HttpRequestException exception;
}
