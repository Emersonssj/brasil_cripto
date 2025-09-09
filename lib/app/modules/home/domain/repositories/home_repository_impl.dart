import 'package:result_dart/result_dart.dart';

import '../../../../core/services/http/exceptions/http_request_exception.dart';
import '../../../../shared/mapper/mapper.dart';
import '../../data/datasources/home_datasource.dart';
import '../../data/models/trending_coin_model.dart';
import '../entities/trending_coin_entity.dart';
import 'home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this.datasource, this.coinMapper);

  final HomeDatasource datasource;
  final Mapper<TrendingCoinEntity, TrendingCoinModel> coinMapper;

  @override
  AsyncResult<List<TrendingCoinEntity>, HttpRequestException> getTrendingCoins() async {
    var result = datasource.getTrendingCoins();

    return result.fold(
      (success) => Success(success.map((m) => coinMapper.toEntity(m)).toList()),
      (failure) => Failure(failure),
    );
  }
}
