import 'package:get_it/get_it.dart';

import '../../modules/coin_details/coin_details_dependency_injection.dart';
import '../../modules/coin_search/coin_search_dependency_injection.dart';
import '../../modules/favorites_coins/favorite_coins_dependency_injection.dart';
import '../../modules/home/home_dependency_injection.dart';
import '../environment/environment.dart';
import '../services/hive/hive_service.dart';
import '../services/http/http_service.dart';
import '../services/http/impl/http_service_impl.dart';

class DependencyInjection {
  static const apiUrlInstanceName = 'api_url';

  static void load() {
    _loadExternalServices();
    _loadServices();
    HomeDependencyInjection.load();
    CoinDetailsDependencyInjection.load();
    CoinSearchDependencyInjection.load();
    FavoriteCoinsDependencyInjection.load();
  }

  static void _loadExternalServices() {
    registerDependency<HiveService>(() => HiveService());
  }

  static void _loadServices() {
    registerDependency<HttpService>(
      () => HttpServiceImpl(baseUrl: Environment.apiBaseUrl),
      instanceName: apiUrlInstanceName,
    );
  }
}

final GetIt _getIt = GetIt.instance;

registerDependency<T extends Object>(FactoryFunc<T> func, {String? instanceName}) {
  if (!_getIt.isRegistered<T>(instanceName: instanceName)) {
    _getIt.registerFactory<T>(func, instanceName: instanceName);
  }
}

registerLazySingleton<T extends Object>(FactoryFunc<T> func) {
  if (!_getIt.isRegistered<T>()) {
    _getIt.registerLazySingleton<T>(func);
  }
}

T getDependency<T extends Object>({String? instanceName}) {
  return _getIt.get<T>(instanceName: instanceName);
}
