import 'package:equatable/equatable.dart';

class CoinComplementEntity extends Equatable {
  final double currentPrice;
  final double marketCapChangePercentage24h;

  const CoinComplementEntity({required this.currentPrice, required this.marketCapChangePercentage24h});

  @override
  List<Object?> get props => [currentPrice, marketCapChangePercentage24h];
}
