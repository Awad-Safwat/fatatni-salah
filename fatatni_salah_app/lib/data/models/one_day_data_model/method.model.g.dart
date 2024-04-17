// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'method.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MethodAdapter extends TypeAdapter<Method> {
  @override
  final int typeId = 6;

  @override
  Method read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Method(
      id: fields[0] as int?,
      name: fields[1] as String?,
      params: fields[2] as Params?,
      location: fields[3] as Location?,
    );
  }

  @override
  void write(BinaryWriter writer, Method obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.params)
      ..writeByte(3)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MethodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
