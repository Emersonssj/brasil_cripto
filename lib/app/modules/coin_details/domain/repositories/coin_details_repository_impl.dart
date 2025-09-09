import 'package:result_dart/result_dart.dart';

import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../../../../shared/mapper/mapper.dart';
import '../../data/datasource/coin_details_datasource.dart';
import '../../data/models/models.dart';
import '../entities/entities.dart';
import 'coin_details_repository.dart';

class CoinDetailsRepositoryImpl implements CoinDetailsRepository {
  CoinDetailsRepositoryImpl(this.datasource, this.coinDetailsMapper, this.marketChartMapper);

  final CoinDetailsDatasource datasource;
  final Mapper<CoinDetailsEntity, CoinDetailsModel> coinDetailsMapper;
  final Mapper<MarketChartEntity, MarketChartModel> marketChartMapper;

  @override
  AsyncResult<CoinDetailsEntity, HttpRequestException> getCoinDetails(String id) async {
    var result = datasource.getCoinDetails(id);

    return result.fold((success) => Success(coinDetailsMapper.toEntity(success)), (failure) => Failure(failure));
  }

  @override
  AsyncResult<MarketChartEntity, HttpRequestException> getChartInfo(String id, String days) async {
    var result = datasource.getChartInfo(id, days);

    return result.fold((success) => Success(marketChartMapper.toEntity(success)), (failure) => Failure(failure));
  }
}
