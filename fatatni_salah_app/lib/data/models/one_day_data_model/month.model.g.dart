// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MonthAdapter extends TypeAdapter<Month> {
  @override
  final int typeId = 7;

  @override
  Month read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Month(
      number: fields[0] as int?,
      en: fields[1] as String?,
      ar: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Month obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.en)
      ..writeByte(2)
      ..write(obj.ar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
