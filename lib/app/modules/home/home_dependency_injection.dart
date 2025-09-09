import '../../core/dependency_injection/dependency_injection.dart';
import '../../core/services/http/http_service.dart';
import '../../shared/mapper/mapper.dart';
import 'data/datasources/home_datasource.dart';
import 'data/datasources/home_datasource_impl.dart';
import 'data/mappers/trending_coin_mapper.dart';
import 'data/models/trending_coin_model.dart';
import 'domain/entities/trending_coin_entity.dart';
import 'domain/repositories/home_repository.dart';
import 'domain/repositories/home_repository_impl.dart';
import 'presentation/blocs/home_bloc.dart';
import 'presentation/blocs/home_event.dart';

class HomeDependencyInjection {
  static void load() {
    _loadDatasoucers();
    _loadMappers();
    _loadRepositories();
    _loadBlocs();
  }

  static void _loadDatasoucers() {
    registerDependency<HomeDatasource>(
      () => HomeDatasourceImpl(getDependency<HttpService>(instanceName: DependencyInjection.apiUrlInstanceName)),
    );
  }

  static void _loadMappers() {
    registerDependency<Mapper<TrendingCoinEntity, TrendingCoinModel>>(() => TrendingCoinMapper());
  }

  static void _loadRepositories() {
    registerDependency<HomeRepository>(
      () => HomeRepositoryImpl(
        getDependency<HomeDatasource>(),
        getDependency<Mapper<TrendingCoinEntity, TrendingCoinModel>>(),
      ),
    );
  }

  static void _loadBlocs() {
    registerLazySingleton<HomeBloc>(() => HomeBloc(getDependency<HomeRepository>())..add(GetTrendingCoinsEvent()));
  }
}
