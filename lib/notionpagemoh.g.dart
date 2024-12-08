// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notionpagemoh.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotionPageMohAdapter extends TypeAdapter<NotionPageMoh> {
  @override
  final int typeId = 0;

  @override
  NotionPageMoh read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotionPageMoh(
      title: fields[0] as String,
      description: fields[1] as String?,
      price: fields[3] as num?,
      area: fields[2] as String?,
      category: fields[4] as String?,
      pictureUrls: (fields[5] as List?)?.cast<String>(),
      pageId: fields[6] as String?,
      lastEditedTime: fields[7] as String?,
      date: fields[8] as String?,
      number: fields[9] as num?,
      pdfUrls: (fields[10] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, NotionPageMoh obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.area)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.pictureUrls)
      ..writeByte(6)
      ..write(obj.pageId)
      ..writeByte(7)
      ..write(obj.lastEditedTime)
      ..writeByte(8)
      ..write(obj.date)
      ..writeByte(9)
      ..write(obj.number)
      ..writeByte(10)
      ..write(obj.pdfUrls);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotionPageMohAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
