class CoinComplementModel {
  final double current_price;
  final double market_cap_change_percentage_24h;

  CoinComplementModel({required this.current_price, required this.market_cap_change_percentage_24h});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'current_price': current_price,
      'market_cap_change_percentage_24h': market_cap_change_percentage_24h,
    };
  }

  factory CoinComplementModel.fromMap(Map<String, dynamic> map) {
    return CoinComplementModel(
      current_price: map['current_price'] as double,
      market_cap_change_percentage_24h: map['market_cap_change_percentage_24h'] as double,
    );
  }
}
