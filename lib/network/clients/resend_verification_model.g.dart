// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resend_verification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResendVerificationModelAdapter
    extends TypeAdapter<ResendVerificationModel> {
  @override
  final int typeId = 1;

  @override
  ResendVerificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResendVerificationModel()..email = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, ResendVerificationModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResendVerificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
