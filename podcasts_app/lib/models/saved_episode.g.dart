// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_episode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedEpisodeAdapter extends TypeAdapter<SavedEpisode> {
  @override
  final int typeId = 1;

  @override
  SavedEpisode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedEpisode(
      position: fields[0] as int,
      duration: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SavedEpisode obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.position)
      ..writeByte(1)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedEpisodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
