import 'package:hive/hive.dart';

part 'coin_hive_entity.g.dart';

@HiveType(typeId: 0)
class CoinHiveEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String apiSymbol;

  @HiveField(3)
  final String symbol;

  @HiveField(4)
  final int marketCapRank;

  @HiveField(5)
  final String thumb;

  @HiveField(6)
  final String large;

  const CoinHiveEntity({
    required this.id,
    required this.name,
    required this.apiSymbol,
    required this.symbol,
    required this.marketCapRank,
    required this.thumb,
    required this.large,
  });
}
