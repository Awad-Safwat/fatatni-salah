// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_day_data.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OneDayDataModelAdapter extends TypeAdapter<OneDayDataModel> {
  @override
  final int typeId = 9;

  @override
  OneDayDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OneDayDataModel(
      timings: fields[0] as Timings?,
      date: fields[1] as Date?,
      meta: fields[2] as Meta?,
    );
  }

  @override
  void write(BinaryWriter writer, OneDayDataModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.timings)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.meta);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OneDayDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
