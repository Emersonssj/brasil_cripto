import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../database/adapters/coin_hive_entity.dart';

class HiveService {
  // Nome do Box definido no main.dart
  static const String _boxName = 'favorite_coins';

  // Obtém a instância do Box que já foi aberto
  final Box<CoinHiveEntity> _box = Hive.box<CoinHiveEntity>(_boxName);

  /// Adiciona uma moeda à lista de favoritos.
  /// Se uma moeda com o mesmo ID já existir, ela será substituída.
  Future<void> addCoin(CoinHiveEntity coin) async {
    // Usamos o 'id' da moeda como chave única no box.
    await _box.put(coin.id, coin);
  }

  /// Remove uma moeda da lista de favoritos com base no seu ID.
  Future<void> removeCoin(String coinId) async {
    await _box.delete(coinId);
  }

  /// Retorna a lista de todas as moedas favoritas salvas.
  List<CoinHiveEntity> getAllCoins() {
    // .values retorna um Iterable com todos os objetos, então convertemos para List.
    return _box.values.toList();
  }

  /// Verifica se uma moeda específica já está salva como favorita.
  bool isFavorite(String coinId) {
    return _box.containsKey(coinId);
  }

  // Opcional: Para ouvir mudanças no Box em tempo real (útil com ValueListenableBuilder)
  ValueListenable<Box<CoinHiveEntity>> listenable() {
    return _box.listenable();
  }
}
