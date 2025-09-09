import 'package:result_dart/result_dart.dart';

import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../../../../core/services/http/exceptions/http_unhandled_exception.dart';
import '../../../../core/services/http/http_service.dart';
import '../models/trending_coin_model.dart';
import 'home_datasource.dart';

class HomeDatasourceImpl implements HomeDatasource {
  HomeDatasourceImpl(this._api);

  final HttpService _api;

  @override
  AsyncResult<List<TrendingCoinModel>, HttpRequestException> getTrendingCoins() async {
    final result = await _api.get(
      '/coins/markets',
      queryParams: {'order': 'market_cap_desc', 'per_page': '50', 'page': '1', 'vs_currency': 'usd'},
    );

    return result.flatMap((response) {
      try {
        final coins = (response.content as List).map((e) => TrendingCoinModel.fromMap(e)).toList();
        return Success(coins);
      } catch (e) {
        return Failure(HttpUnhandledException.unknown());
      }
    });
  }
}
