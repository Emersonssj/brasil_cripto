class GraphicInfoEntity {
  final List<GraphicPointEntity> prices;
  final List<GraphicPointEntity> marketCaps;
  final List<GraphicPointEntity> totalVolumes;

  GraphicInfoEntity({required this.prices, required this.marketCaps, required this.totalVolumes});
}

class GraphicPointEntity {
  final DateTime timestamp;
  final double value;

  GraphicPointEntity({required this.timestamp, required this.value});
}
