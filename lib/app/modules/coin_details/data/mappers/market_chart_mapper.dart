import '../../../../shared/mapper/mapper.dart';
import '../../domain/entities/chart_data_point_entity.dart';
import '../../domain/entities/market_chart_entity.dart';
import '../models/chart_data_point_model.dart';
import '../models/market_chart_model.dart';

class MarketChartMapper extends Mapper<MarketChartEntity, MarketChartModel> {
  MarketChartMapper(this._chartDataPointMapper);

  final Mapper<ChartDataPointEntity, ChartDataPointModel> _chartDataPointMapper;

  @override
  MarketChartEntity toEntity(MarketChartModel model) {
    return MarketChartEntity(
      prices: _chartDataPointMapper.toEntityList(model.prices),
      marketCaps: _chartDataPointMapper.toEntityList(model.marketCaps),
      totalVolumes: _chartDataPointMapper.toEntityList(model.totalVolumes),
    );
  }

  @override
  MarketChartModel toModel(MarketChartEntity entity) {
    return MarketChartModel(
      prices: _chartDataPointMapper.toModelList(entity.prices),
      marketCaps: _chartDataPointMapper.toModelList(entity.marketCaps),
      totalVolumes: _chartDataPointMapper.toModelList(entity.totalVolumes),
    );
  }
}
