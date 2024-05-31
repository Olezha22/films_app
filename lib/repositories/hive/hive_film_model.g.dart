// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_film_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveFilmModelAdapter extends TypeAdapter<HiveFilmModel> {
  @override
  final int typeId = 0;

  @override
  HiveFilmModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveFilmModel(
      title: fields[0] as String,
      description: fields[1] as String,
      date: fields[2] as String,
      image: fields[3] as String,
      rate: fields[4] as double,
      genres: fields[5] as String,
      isFavorite: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveFilmModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.rate)
      ..writeByte(5)
      ..write(obj.genres)
      ..writeByte(6)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveFilmModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
