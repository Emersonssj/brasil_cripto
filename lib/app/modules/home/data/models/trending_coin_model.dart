import 'dart:convert';

class TrendingCoinModel {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double marketCap;
  final int marketCapRank;
  final double? fullyDilutedValuation;
  final double totalVolume;
  final double high24h;
  final double low24h;
  final double priceChange24h;
  final double priceChangePercentage24h;
  final double marketCapChange24h;
  final double marketCapChangePercentage24h;
  final double circulatingSupply;
  final double? totalSupply;
  final double? maxSupply;
  final double ath;
  final double athChangePercentage;
  final String athDate;
  final double atl;
  final double atlChangePercentage;
  final String atlDate;
  final String lastUpdated;

  TrendingCoinModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    this.fullyDilutedValuation,
    required this.totalVolume,
    required this.high24h,
    required this.low24h,
    required this.priceChange24h,
    required this.priceChangePercentage24h,
    required this.marketCapChange24h,
    required this.marketCapChangePercentage24h,
    required this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    required this.lastUpdated,
  });

  factory TrendingCoinModel.fromMap(Map<String, dynamic> map) {
    return TrendingCoinModel(
      id: map['id'] as String,
      symbol: map['symbol'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      currentPrice: (map['current_price'] as num).toDouble(),
      marketCap: (map['market_cap'] as num).toDouble(),
      marketCapRank: map['market_cap_rank'] as int,
      fullyDilutedValuation: (map['fully_diluted_valuation'] as num?)?.toDouble(),
      totalVolume: (map['total_volume'] as num).toDouble(),
      high24h: (map['high_24h'] as num).toDouble(),
      low24h: (map['low_24h'] as num).toDouble(),
      priceChange24h: (map['price_change_24h'] as num).toDouble(),
      priceChangePercentage24h: (map['price_change_percentage_24h'] as num).toDouble(),
      marketCapChange24h: (map['market_cap_change_24h'] as num).toDouble(),
      marketCapChangePercentage24h: (map['market_cap_change_percentage_24h'] as num).toDouble(),
      circulatingSupply: (map['circulating_supply'] as num).toDouble(),
      totalSupply: (map['total_supply'] as num?)?.toDouble(),
      maxSupply: (map['max_supply'] as num?)?.toDouble(),
      ath: (map['ath'] as num).toDouble(),
      athChangePercentage: (map['ath_change_percentage'] as num).toDouble(),
      athDate: map['ath_date'] as String,
      atl: (map['atl'] as num).toDouble(),
      atlChangePercentage: (map['atl_change_percentage'] as num).toDouble(),
      atlDate: map['atl_date'] as String,
      lastUpdated: map['last_updated'] as String,
    );
  }

  /// Converte a instância de TrendingCoinModel em um objeto Map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': image,
      'current_price': currentPrice,
      'market_cap': marketCap,
      'market_cap_rank': marketCapRank,
      'fully_diluted_valuation': fullyDilutedValuation,
      'total_volume': totalVolume,
      'high_24h': high24h,
      'low_24h': low24h,
      'price_change_24h': priceChange24h,
      'price_change_percentage_24h': priceChangePercentage24h,
      'market_cap_change_24h': marketCapChange24h,
      'market_cap_change_percentage_24h': marketCapChangePercentage24h,
      'circulating_supply': circulatingSupply,
      'total_supply': totalSupply,
      'max_supply': maxSupply,
      'ath': ath,
      'ath_change_percentage': athChangePercentage,
      'ath_date': athDate,
      'atl': atl,
      'atl_change_percentage': atlChangePercentage,
      'atl_date': atlDate,
      'last_updated': lastUpdated,
    };
  }

  factory TrendingCoinModel.fromJson(String source) =>
      TrendingCoinModel.fromMap(json.decode(source) as Map<String, dynamic>);
  String toJson() => json.encode(toMap());
}
