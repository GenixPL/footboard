// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Move _$MoveFromJson(Map<String, dynamic> json) {
  return Move(
    performedBy: json['performedBy'] as String,
    sX: json['sX'] as int,
    sY: json['sY'] as int,
    eX: json['eX'] as int,
    eY: json['eY'] as int,
  );
}

Map<String, dynamic> _$MoveToJson(Move instance) => <String, dynamic>{
      'performedBy': instance.performedBy,
      'sX': instance.sX,
      'sY': instance.sY,
      'eX': instance.eX,
      'eY': instance.eY,
    };
