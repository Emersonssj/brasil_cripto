import 'package:equatable/equatable.dart';

class CoinDetailsEntity extends Equatable {
  final String id;
  final String symbol;
  final String name;
  final String description;
  final String links;
  final String image;
  final int marketCapRank;

  const CoinDetailsEntity({
    required this.id,
    required this.symbol,
    required this.name,
    required this.description,
    required this.links,
    required this.image,
    required this.marketCapRank,
  });

  @override
  List<Object?> get props => [id, symbol, name, description, links, image, marketCapRank];
}
