import 'package:hive_flutter/hive_flutter.dart';

import 'adapters/coin_hive_entity.dart';

class HiveConfig {
  static Future<void> load() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CoinHiveEntityAdapter());
    await Hive.openBox<CoinHiveEntity>('favorite_coins');
  }
}
