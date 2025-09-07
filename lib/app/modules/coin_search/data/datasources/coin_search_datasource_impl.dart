import 'package:result_dart/result_dart.dart';

import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../../../../core/services/http/exceptions/http_unhandled_exception.dart';
import '../../../../core/services/http/http_service.dart';
import '../../../coin_search/data/models/coin_model.dart';
import 'coin_search_datasource.dart';

class CoinSearchDatasourceImpl implements CoinSearchDatasource {
  CoinSearchDatasourceImpl(this._api);

  final HttpService _api;

  @override
  AsyncResult<List<CoinModel>, HttpRequestException> getCoins(String query) async {
    final result = await _api.get('/search', queryParams: {'query': query});

    return result.flatMap((response) {
      try {
        final coins = (response.content['coins'] as List).map((e) => CoinModel.fromMap(e)).toList();
        return Success(coins);
      } catch (e) {
        return Failure(HttpUnhandledException.unknown());
      }
    });
  }
}
