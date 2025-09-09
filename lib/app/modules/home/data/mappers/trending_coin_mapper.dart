import '../../../../shared/mapper/mapper.dart';
import '../../domain/entities/trending_coin_entity.dart';
import '../models/trending_coin_model.dart';

class TrendingCoinMapper extends Mapper<TrendingCoinEntity, TrendingCoinModel> {
  @override
  TrendingCoinEntity toEntity(TrendingCoinModel model) {
    return TrendingCoinEntity(
      id: model.id,
      symbol: model.symbol,
      name: model.name,
      image: model.image,
      currentPrice: model.currentPrice,
      marketCap: model.marketCap,
      marketCapRank: model.marketCapRank,
      totalVolume: model.totalVolume,
      high24h: model.high24h,
      low24h: model.low24h,
      priceChange24h: model.priceChange24h,
      priceChangePercentage24h: model.priceChangePercentage24h,
      marketCapChange24h: model.marketCapChange24h,
      marketCapChangePercentage24h: model.marketCapChangePercentage24h,
      circulatingSupply: model.circulatingSupply,
      ath: model.ath,
      athChangePercentage: model.athChangePercentage,
      athDate: model.athDate,
      atl: model.atl,
      atlChangePercentage: model.atlChangePercentage,
      atlDate: model.atlDate,
      lastUpdated: model.lastUpdated,
    );
  }

  @override
  TrendingCoinModel toModel(TrendingCoinEntity entity) {
    return TrendingCoinModel(
      id: entity.id,
      symbol: entity.symbol,
      name: entity.name,
      image: entity.image,
      currentPrice: entity.currentPrice,
      marketCap: entity.marketCap,
      marketCapRank: entity.marketCapRank,
      totalVolume: entity.totalVolume,
      high24h: entity.high24h,
      low24h: entity.low24h,
      priceChange24h: entity.priceChange24h,
      priceChangePercentage24h: entity.priceChangePercentage24h,
      marketCapChange24h: entity.marketCapChange24h,
      marketCapChangePercentage24h: entity.marketCapChangePercentage24h,
      circulatingSupply: entity.circulatingSupply,
      ath: entity.ath,
      athChangePercentage: entity.athChangePercentage,
      athDate: entity.athDate,
      atl: entity.atl,
      atlChangePercentage: entity.atlChangePercentage,
      atlDate: entity.atlDate,
      lastUpdated: entity.lastUpdated,
    );
  }
}
