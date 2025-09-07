class GraphicInfoModel {
  final List<GraphicPointModel> prices;
  final List<GraphicPointModel> market_caps;
  final List<GraphicPointModel> total_volumes;

  GraphicInfoModel({required this.prices, required this.market_caps, required this.total_volumes});

  factory GraphicInfoModel.fromJson(Map<String, dynamic> json) {
    List<GraphicPointModel> parseChartData(String key) {
      if (json[key] != null && json[key] is List) {
        return (json[key] as List<dynamic>).map((item) => GraphicPointModel.fromList(item as List<dynamic>)).toList();
      }
      return [];
    }

    return GraphicInfoModel(
      prices: parseChartData('prices'),
      market_caps: parseChartData('market_caps'),
      total_volumes: parseChartData('total_volumes'),
    );
  }
}

class GraphicPointModel {
  final DateTime timestamp;
  final double value;

  GraphicPointModel({required this.timestamp, required this.value});

  factory GraphicPointModel.fromList(List<dynamic> list) {
    if (list.length != 2) {
      throw ArgumentError('A lista deve conter exatamente 2 elementos (timestamp e valor)');
    }
    return GraphicPointModel(
      timestamp: DateTime.fromMillisecondsSinceEpoch(list[0] as int),
      value: (list[1] as num).toDouble(),
    );
  }
}
