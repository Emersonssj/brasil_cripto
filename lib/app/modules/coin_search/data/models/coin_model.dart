class CoinModel {
  final String id;
  final String name;
  final String api_symbol;
  final String symbol;
  final int market_cap_rank;
  final String thumb;
  final String large;

  CoinModel({
    required this.id,
    required this.name,
    required this.api_symbol,
    required this.symbol,
    required this.market_cap_rank,
    required this.thumb,
    required this.large,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'api_symbol': api_symbol,
      'symbol': symbol,
      'market_cap_rank': market_cap_rank,
      'thumb': thumb,
      'large': large,
    };
  }

  factory CoinModel.fromMap(Map<String, dynamic> map) {
    return CoinModel(
      id: map['id'] as String,
      name: map['name'] as String,
      api_symbol: map['api_symbol'] as String,
      symbol: map['symbol'] as String,
      market_cap_rank: map['market_cap_rank'] as int,
      thumb: map['thumb'] as String,
      large: map['large'] as String,
    );
  }
}
