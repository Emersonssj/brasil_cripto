import 'package:result_dart/result_dart.dart';

import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../models/trending_coin_model.dart';

abstract class HomeDatasource {
  AsyncResult<List<TrendingCoinModel>, HttpRequestException> getTrendingCoins();
}
