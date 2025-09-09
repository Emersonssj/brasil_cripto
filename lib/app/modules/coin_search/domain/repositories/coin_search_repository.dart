import 'package:result_dart/result_dart.dart';

import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../entities/entities.dart';

abstract class CoinSearchRepository {
  AsyncResult<List<CoinEntity>, HttpRequestException> getCoins(String query);
  AsyncResult<CoinComplementEntity, HttpRequestException> getCoinsComplement(String ids);
}
