import 'package:result_dart/result_dart.dart';

import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../models/models.dart';

abstract class CoinDetailsDatasource {
  AsyncResult<CoinDetailsModel, HttpRequestException> getCoinDetails(String id);
  AsyncResult<MarketChartModel, HttpRequestException> getChartInfo(String id, String days);
}
