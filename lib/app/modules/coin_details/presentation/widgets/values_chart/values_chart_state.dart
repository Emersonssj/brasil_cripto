import '../../../domain/entities/market_chart_entity.dart';

abstract class ValuesChartState {}

class ValuesChartInitialState extends ValuesChartState {}

class ValuesChartLoadingState extends ValuesChartState {}

class GetChartInfoSuccessState extends ValuesChartState {
  GetChartInfoSuccessState({required this.marketChart});

  final MarketChartEntity marketChart;
}

class GetChartInfoErrorState extends ValuesChartState {
  GetChartInfoErrorState();
}
