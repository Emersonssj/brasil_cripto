import 'chart_data_point_model.dart';

class MarketChartModel {
  final List<ChartDataPointModel> prices;
  final List<ChartDataPointModel> marketCaps;
  final List<ChartDataPointModel> totalVolumes;

  MarketChartModel({required this.prices, required this.marketCaps, required this.totalVolumes});

  factory MarketChartModel.fromJson(Map<String, dynamic> json) {
    return MarketChartModel(
      prices: _parseChartDataList(json['prices']),
      marketCaps: _parseChartDataList(json['market_caps']),
      totalVolumes: _parseChartDataList(json['total_volumes']),
    );
  }

  static List<ChartDataPointModel> _parseChartDataList(List<dynamic>? data) {
    if (data == null || data.isEmpty) {
      return [];
    }

    return data.map((item) {
      return ChartDataPointModel(
        date: DateTime.fromMillisecondsSinceEpoch(item[0]),
        value: (item[1] as num).toDouble(),
      );
    }).toList();
  }
}
