import '../../core/dependency_injection/dependency_injection.dart';
import '../../core/services/hive/hive_service.dart';
import '../favorites_coins/presentation/blocs/favorite_coins_bloc.dart';
import '../favorites_coins/presentation/blocs/favorite_coins_event.dart';

class FavoriteCoinsDependencyInjection {
  static void load() {
    _loadDatasoucers();
    _loadMappers();
    _loadRepositories();
    _loadBlocs();
  }

  static void _loadDatasoucers() {}

  static void _loadMappers() {}

  static void _loadRepositories() {}

  static void _loadBlocs() {
    registerLazySingleton<FavoriteCoinsBloc>(
      () => FavoriteCoinsBloc(getDependency<HiveService>())..add(LoadFavoritesCoins()),
    );
  }
}
