import 'package:result_dart/result_dart.dart';

import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../entities/entities.dart';

abstract class CoinDetailsRepository {
  AsyncResult<CoinDetailsEntity, HttpRequestException> getCoinDetails(String id);
  AsyncResult<GraphicInfoEntity, HttpRequestException> getGraphicInfo(String id, String days);
}
