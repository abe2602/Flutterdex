// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieCMAdapter extends TypeAdapter<MovieCM> {
  @override
  final typeId = 1;

  @override
  MovieCM read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieCM(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MovieCM obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.isFavorite);
  }
}
