import '../../../../shared/mapper/mapper.dart';
import '../../domain/entities/coin_details_entity.dart';
import '../../domain/entities/coin_market_data_entity.dart';
import '../models/coin_details_model.dart';
import '../models/coin_market_data_model.dart';

class CoinDetailsMapper extends Mapper<CoinDetailsEntity, CoinDetailsModel> {
  CoinDetailsMapper(this._coinMarketDataMapper);

  final Mapper<CoinMarketDataEntity, CoinMarketDataModel> _coinMarketDataMapper;

  @override
  CoinDetailsEntity toEntity(CoinDetailsModel model) {
    return CoinDetailsEntity(
      id: model.id,
      symbol: model.symbol,
      name: model.name,
      description: model.description,
      links: model.links,
      image: model.image,
      marketCapRank: model.market_cap_rank,
      coinMarketData: _coinMarketDataMapper.toEntity(model.coinMarketData),
    );
  }

  @override
  CoinDetailsModel toModel(CoinDetailsEntity entity) {
    return CoinDetailsModel(
      id: entity.id,
      symbol: entity.symbol,
      name: entity.name,
      description: entity.description,
      links: entity.links,
      image: entity.image,
      market_cap_rank: entity.marketCapRank,
      coinMarketData: _coinMarketDataMapper.toModel(entity.coinMarketData),
    );
  }
}
