import '../../../../shared/mapper/mapper.dart';
import '../../domain/entities/coin_complement_entity.dart';
import '../models/coin_complement_model.dart';

class CoinComplementMapper extends Mapper<CoinComplementEntity, CoinComplementModel> {
  @override
  CoinComplementEntity toEntity(CoinComplementModel model) {
    return CoinComplementEntity(
      currentPrice: model.current_price,
      marketCapChangePercentage24h: model.market_cap_change_percentage_24h,
    );
  }

  @override
  CoinComplementModel toModel(CoinComplementEntity entity) {
    return CoinComplementModel(
      current_price: entity.currentPrice,
      market_cap_change_percentage_24h: entity.marketCapChangePercentage24h,
    );
  }
}
