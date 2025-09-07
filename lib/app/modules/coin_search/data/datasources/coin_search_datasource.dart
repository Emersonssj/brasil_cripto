import 'package:result_dart/result_dart.dart';

import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../models/coin_model.dart';

abstract class CoinSearchDatasource {
  AsyncResult<List<CoinModel>, HttpRequestException> getCoins(String query);
}
