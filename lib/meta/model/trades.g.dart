// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trades.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TradesAdapter extends TypeAdapter<Trades> {
  @override
  final int typeId = 0;

  @override
  Trades read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trades(
      stockName: fields[0] as String,
      stockPrice: fields[1] as double,
      valueofstock: fields[2] as double,
      day: fields[4] as DateTime,
      qty: fields[3] as int,
      profitandloss: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Trades obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.stockName)
      ..writeByte(1)
      ..write(obj.stockPrice)
      ..writeByte(2)
      ..write(obj.valueofstock)
      ..writeByte(3)
      ..write(obj.qty)
      ..writeByte(4)
      ..write(obj.day)
      ..writeByte(5)
      ..write(obj.profitandloss);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TradesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
