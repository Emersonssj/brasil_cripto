import 'package:equatable/equatable.dart';

class CoinMarketDataEntity extends Equatable {
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

  const CoinMarketDataEntity({
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

  @override
  List<Object?> get props => [
    currentPriceUsd,
    marketCapUsd,
    totalVolumeUsd,
    high24hUsd,
    low24hUsd,
    priceChangePercentage24h,
    priceChangePercentage7d,
    priceChangePercentage30d,
    priceChangePercentage1y,
    circulatingSupply,
  ];
}
