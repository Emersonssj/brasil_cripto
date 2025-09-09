import 'package:result_dart/result_dart.dart';

import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../models/models.dart';

abstract class CoinSearchDatasource {
  AsyncResult<List<CoinModel>, HttpRequestException> getCoins(String query);
  AsyncResult<CoinComplementModel, HttpRequestException> getCoinsComplement(String id);
}
