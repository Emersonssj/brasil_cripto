import 'package:equatable/equatable.dart';

class CoinEntity extends Equatable {
  final String id;
  final String name;
  final String apiSymbol;
  final String symbol;
  final int marketCapRank;
  final String thumb;
  final String large;

  const CoinEntity({
    required this.id,
    required this.name,
    required this.apiSymbol,
    required this.symbol,
    required this.marketCapRank,
    required this.thumb,
    required this.large,
  });

  @override
  List<Object?> get props => [id, name, apiSymbol, symbol, marketCapRank, thumb, large];
}
