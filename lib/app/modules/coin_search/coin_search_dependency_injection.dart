import '../../core/dependency_injection/dependency_injection.dart';
import '../../core/services/http/http_service.dart';
import '../../shared/mapper/mapper.dart';
import 'data/datasources/coin_search_datasource.dart';
import 'data/datasources/coin_search_datasource_impl.dart';
import 'data/mappers/coin_mapper.dart';
import 'data/models/coin_model.dart';
import 'domain/entities/coin_entity.dart';
import 'domain/repositories/coin_search_repository.dart';
import 'domain/repositories/coin_search_repository_impl.dart';
import 'presentation/blocs/coin_search_bloc.dart';

class CoinSearchDependencyInjection {
  static void load() {
    _loadDatasoucers();
    _loadMappers();
    _loadRepositories();
    _loadBlocs();
  }

  static void _loadDatasoucers() {
    registerDependency<CoinSearchDatasource>(
      () => CoinSearchDatasourceImpl(getDependency<HttpService>(instanceName: DependencyInjection.apiUrlInstanceName)),
    );
  }

  static void _loadMappers() {
    registerDependency<Mapper<CoinEntity, CoinModel>>(() => CoinMapper());
  }

  static void _loadRepositories() {
    registerDependency<CoinSearchRepository>(
      () => CoinSearchRepositoryImpl(
        getDependency<CoinSearchDatasource>(),
        getDependency<Mapper<CoinEntity, CoinModel>>(),
      ),
    );
  }

  static void _loadBlocs() {
    registerLazySingleton<CoinSearchBloc>(() => CoinSearchBloc(getDependency<CoinSearchRepository>()));
  }
}
