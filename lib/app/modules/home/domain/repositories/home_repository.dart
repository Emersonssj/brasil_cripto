import 'package:result_dart/result_dart.dart';

import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../entities/trending_coin_entity.dart';

abstract class HomeRepository {
  AsyncResult<List<TrendingCoinEntity>, HttpRequestException> getTrendingCoins();
}
