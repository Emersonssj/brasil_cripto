import 'package:result_dart/result_dart.dart';

import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../../../../core/services/http/exceptions/http_unhandled_exception.dart';
import '../../../../core/services/http/http_service.dart';
import '../../../coin_details/data/models/coin_details_model.dart';
import '../../../coin_details/data/models/graphic_info_model.dart';
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
  AsyncResult<GraphicInfoModel, HttpRequestException> getGraphicInfo(String id, String days) async {
    final result = await _api.get('/coins/$id/market_chart', queryParams: {'days': days});

    return result.flatMap((response) {
      try {
        final coins = GraphicInfoModel.fromJson(response.content['data']);
        return Success(coins);
      } catch (e) {
        return Failure(HttpUnhandledException.unknown());
      }
    });
  }
}
