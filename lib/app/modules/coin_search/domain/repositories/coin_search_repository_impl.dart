import 'package:result_dart/result_dart.dart';

import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../../../../shared/mapper/mapper.dart';
import '../../../coin_search/domain/entities/coin_entity.dart';
import '../../../coin_search/data/models/coin_model.dart';
import '../../data/datasources/coin_search_datasource.dart';
import 'coin_search_repository.dart';

class CoinSearchRepositoryImpl implements CoinSearchRepository {
  CoinSearchRepositoryImpl(this.datasource, this.coinMapper);

  final CoinSearchDatasource datasource;
  final Mapper<CoinEntity, CoinModel> coinMapper;

  @override
  AsyncResult<List<CoinEntity>, HttpRequestException> getCoins(String query) async {
    var result = datasource.getCoins(query);

    return result.fold(
      (success) => Success(success.map((m) => coinMapper.toEntity(m)).toList()),
      (failure) => Failure(failure),
    );
  }
}
