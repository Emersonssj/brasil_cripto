import 'package:result_dart/result_dart.dart';

import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../../../coin_search/domain/entities/coin_entity.dart';

abstract class CoinSearchRepository {
  AsyncResult<List<CoinEntity>, HttpRequestException> getCoins(String query);
}
