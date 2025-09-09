import 'package:result_dart/result_dart.dart';

import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../../../../core/services/http/exceptions/http_unhandled_exception.dart';
import '../../../../core/services/http/http_service.dart';
import '../models/models.dart';
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

  @override
  AsyncResult<CoinComplementModel, HttpRequestException> getCoinsComplement(String id) async {
    final result = await _api.get('/coins/markets', queryParams: {'ids': id});

    return result.flatMap((response) {
      final info = CoinComplementModel.fromMap(response.content[0]);
      return Success(info);
    });
  }
}
