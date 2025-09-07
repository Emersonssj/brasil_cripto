// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_hive_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CoinHiveEntityAdapter extends TypeAdapter<CoinHiveEntity> {
  @override
  final int typeId = 0;

  @override
  CoinHiveEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CoinHiveEntity(
      id: fields[0] as String,
      name: fields[1] as String,
      apiSymbol: fields[2] as String,
      symbol: fields[3] as String,
      marketCapRank: fields[4] as int,
      thumb: fields[5] as String,
      large: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CoinHiveEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.apiSymbol)
      ..writeByte(3)
      ..write(obj.symbol)
      ..writeByte(4)
      ..write(obj.marketCapRank)
      ..writeByte(5)
      ..write(obj.thumb)
      ..writeByte(6)
      ..write(obj.large);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoinHiveEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
