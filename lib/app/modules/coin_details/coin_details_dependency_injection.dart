import '../../core/dependency_injection/dependency_injection.dart';
import '../../core/services/http/http_service.dart';
import '../../shared/mapper/mapper.dart';
import 'data/datasource/coin_details_datasource.dart';
import 'data/datasource/coin_details_datasource_impl.dart';
import 'data/mappers/mappers.dart';
import 'data/models/models.dart';
import 'domain/entities/entities.dart';
import 'domain/repositories/coin_details_repository.dart';
import 'domain/repositories/coin_details_repository_impl.dart';
import 'presentation/blocs/coin_details_bloc.dart';

class CoinDetailsDependencyInjection {
  static void load() {
    _loadDatasoucers();
    _loadMappers();
    _loadRepositories();
    _loadBlocs();
  }

  static void _loadDatasoucers() {
    registerDependency<CoinDetailsDatasource>(
      () => CoinDetailsDatasourceImpl(getDependency<HttpService>(instanceName: DependencyInjection.apiUrlInstanceName)),
    );
  }

  static void _loadMappers() {
    registerDependency<Mapper<CoinDetailsEntity, CoinDetailsModel>>(() => CoinDetailsMapper());
    registerDependency<Mapper<GraphicInfoEntity, GraphicInfoModel>>(() => GraphicInfoMapper());
  }

  static void _loadRepositories() {
    registerDependency<CoinDetailsRepository>(
      () => CoinDetailsRepositoryImpl(
        getDependency<CoinDetailsDatasource>(),
        getDependency<Mapper<CoinDetailsEntity, CoinDetailsModel>>(),
        getDependency<Mapper<GraphicInfoEntity, GraphicInfoModel>>(),
      ),
    );
  }

  static void _loadBlocs() {
    registerLazySingleton<CoinDetailsBloc>(() => CoinDetailsBloc(getDependency<CoinDetailsRepository>()));
  }
}
