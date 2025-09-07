import '../../../../shared/mapper/mapper.dart';
import '../../domain/entities/coin_entity.dart';
import '../models/coin_model.dart';

class CoinMapper extends Mapper<CoinEntity, CoinModel> {
  @override
  CoinEntity toEntity(CoinModel model) {
    return CoinEntity(
      id: model.id,
      name: model.name,
      apiSymbol: model.api_symbol,
      symbol: model.symbol,
      marketCapRank: model.market_cap_rank,
      thumb: model.thumb,
      large: model.large,
    );
  }

  @override
  CoinModel toModel(CoinEntity entity) {
    return CoinModel(
      id: entity.id,
      name: entity.name,
      api_symbol: entity.apiSymbol,
      symbol: entity.symbol,
      market_cap_rank: entity.marketCapRank,
      thumb: entity.thumb,
      large: entity.large,
    );
  }
}
