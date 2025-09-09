import 'package:equatable/equatable.dart';

import 'chart_data_point_entity.dart';

class MarketChartEntity extends Equatable {
  final List<ChartDataPointEntity> prices;
  final List<ChartDataPointEntity> marketCaps;
  final List<ChartDataPointEntity> totalVolumes;

  const MarketChartEntity({required this.prices, required this.marketCaps, required this.totalVolumes});

  @override
  List<Object?> get props => [prices, marketCaps, totalVolumes];
}
