import '../../domain/entities/entities.dart';

import '../../../../shared/mapper/mapper.dart';
import '../models/coin_market_data_model.dart';

class CoinMarketDataMapper extends Mapper<CoinMarketDataEntity, CoinMarketDataModel> {
  @override
  CoinMarketDataEntity toEntity(CoinMarketDataModel model) {
    return CoinMarketDataEntity(
      currentPriceUsd: model.currentPriceUsd,
      marketCapUsd: model.marketCapUsd,
      totalVolumeUsd: model.totalVolumeUsd,
      high24hUsd: model.high24hUsd,
      low24hUsd: model.low24hUsd,
      priceChangePercentage24h: model.priceChangePercentage24h,
      priceChangePercentage7d: model.priceChangePercentage7d,
      priceChangePercentage30d: model.priceChangePercentage30d,
      priceChangePercentage1y: model.priceChangePercentage1y,
      circulatingSupply: model.circulatingSupply,
    );
  }

  @override
  CoinMarketDataModel toModel(CoinMarketDataEntity entity) {
    return CoinMarketDataModel(
      currentPriceUsd: entity.currentPriceUsd,
      marketCapUsd: entity.marketCapUsd,
      totalVolumeUsd: entity.totalVolumeUsd,
      high24hUsd: entity.high24hUsd,
      low24hUsd: entity.low24hUsd,
      priceChangePercentage24h: entity.priceChangePercentage24h,
      priceChangePercentage7d: entity.priceChangePercentage7d,
      priceChangePercentage30d: entity.priceChangePercentage30d,
      priceChangePercentage1y: entity.priceChangePercentage1y,
      circulatingSupply: entity.circulatingSupply,
    );
  }
}
