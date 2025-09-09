import 'package:result_dart/result_dart.dart';

import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../../../../shared/mapper/mapper.dart';
import '../../data/datasources/coin_search_datasource.dart';
import '../../data/models/models.dart';
import '../entities/entities.dart';
import 'coin_search_repository.dart';

class CoinSearchRepositoryImpl implements CoinSearchRepository {
  CoinSearchRepositoryImpl(this.datasource, this.coinMapper, this.coinsComplementMapper);

  final CoinSearchDatasource datasource;
  final Mapper<CoinEntity, CoinModel> coinMapper;
  final Mapper<CoinComplementEntity, CoinComplementModel> coinsComplementMapper;

  @override
  AsyncResult<List<CoinEntity>, HttpRequestException> getCoins(String query) async {
    var result = datasource.getCoins(query);

    return result.fold(
      (success) => Success(success.map((m) => coinMapper.toEntity(m)).toList()),
      (failure) => Failure(failure),
    );
  }

  @override
  AsyncResult<CoinComplementEntity, HttpRequestException> getCoinsComplement(String ids) {
    var result = datasource.getCoinsComplement(ids);

    return result.fold((success) => Success(coinsComplementMapper.toEntity(success)), (failure) => Failure(failure));
  }
}
