import '../../../../shared/mapper/mapper.dart';
import '../../domain/entities/chart_data_point_entity.dart';
import '../models/chart_data_point_model.dart';

class ChartDataPointMapper extends Mapper<ChartDataPointEntity, ChartDataPointModel> {
  @override
  ChartDataPointEntity toEntity(ChartDataPointModel model) {
    return ChartDataPointEntity(date: model.date, value: model.value);
  }

  @override
  ChartDataPointModel toModel(ChartDataPointEntity entity) {
    return ChartDataPointModel(date: entity.date, value: entity.value);
  }
}
