import 'package:result_dart/result_dart.dart';

import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../../../../core/services/http/exceptions/http_unhandled_exception.dart';
import '../../../../core/services/http/http_service.dart';
import '../models/models.dart';
import 'coin_details_datasource.dart';

class CoinDetailsDatasourceImpl implements CoinDetailsDatasource {
  CoinDetailsDatasourceImpl(this._api);

  final HttpService _api;

  @override
  AsyncResult<CoinDetailsModel, HttpRequestException> getCoinDetails(String id) async {
    final result = await _api.get('/coins/$id');

    return result.flatMap((response) {
      try {
        final coins = CoinDetailsModel.fromMap(response.content);
        return Success(coins);
      } catch (e) {
        return Failure(HttpUnhandledException.unknown());
      }
    });
  }

  @override
  AsyncResult<MarketChartModel, HttpRequestException> getChartInfo(String id, String days) async {
    final result = await _api.get('/coins/$id/market_chart', queryParams: {'days': days, 'vs_currency': 'usd'});

    return result.flatMap((response) {
      try {
        final coins = MarketChartModel.fromJson(response.content);
        return Success(coins);
      } catch (e) {
        return Failure(HttpUnhandledException.unknown());
      }
    });
  }
}
