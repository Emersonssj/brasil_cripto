class CoinMarketDataModel {
  final double currentPriceUsd;
  final double marketCapUsd;
  final double totalVolumeUsd;
  final double high24hUsd;
  final double low24hUsd;
  final double priceChangePercentage24h;
  final double priceChangePercentage7d;
  final double priceChangePercentage30d;
  final double priceChangePercentage1y;
  final double circulatingSupply;

  CoinMarketDataModel({
    required this.currentPriceUsd,
    required this.marketCapUsd,
    required this.totalVolumeUsd,
    required this.high24hUsd,
    required this.low24hUsd,
    required this.priceChangePercentage24h,
    required this.priceChangePercentage7d,
    required this.priceChangePercentage30d,
    required this.priceChangePercentage1y,
    required this.circulatingSupply,
  });

  factory CoinMarketDataModel.fromJson(Map<String, dynamic> json) {
    double safeDouble(dynamic value) => (value as num?)?.toDouble() ?? 0.0;

    return CoinMarketDataModel(
      currentPriceUsd: safeDouble(json['current_price']?['usd']),
      marketCapUsd: safeDouble(json['market_cap']?['usd']),
      totalVolumeUsd: safeDouble(json['total_volume']?['usd']),
      high24hUsd: safeDouble(json['high_24h']?['usd']),
      low24hUsd: safeDouble(json['low_24h']?['usd']),
      priceChangePercentage24h: safeDouble(json['price_change_percentage_24h']),
      priceChangePercentage7d: safeDouble(json['price_change_percentage_7d']),
      priceChangePercentage30d: safeDouble(json['price_change_percentage_30d']),
      priceChangePercentage1y: safeDouble(json['price_change_percentage_1y']),
      circulatingSupply: safeDouble(json['circulating_supply']),
    );
  }
}
