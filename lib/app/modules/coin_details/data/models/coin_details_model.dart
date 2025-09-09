import 'coin_market_data_model.dart';

class CoinDetailsModel {
  final String id;
  final String symbol;
  final String name;
  final String description;
  final String links;
  final String image;
  final int market_cap_rank;
  final CoinMarketDataModel coinMarketData;

  CoinDetailsModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.description,
    required this.links,
    required this.image,
    required this.market_cap_rank,
    required this.coinMarketData,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'symbol': symbol,
      'name': name,
      'description': description,
      'links': links,
      'image': image,
      'market_cap_rank': market_cap_rank,
      'coinMarketData': coinMarketData,
    };
  }

  factory CoinDetailsModel.fromMap(Map<String, dynamic> map) {
    return CoinDetailsModel(
      id: map['id'] as String,
      symbol: map['symbol'] as String,
      name: map['name'] as String,
      description: map['description']['en'] as String,
      links: map['links']['homepage'][0] as String,
      image: map['image']['large'] as String,
      market_cap_rank: map['market_cap_rank'] as int,
      coinMarketData: CoinMarketDataModel.fromJson(map['market_data'] ?? {}),
    );
  }
}
