// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Move _$MoveFromJson(Map<String, dynamic> json) {
  return Move(
    performedBy: json['performedBy'] as String,
    sx: json['sx'] as int,
    sy: json['sy'] as int,
    ex: json['ex'] as int,
    ey: json['ey'] as int,
  );
}

Map<String, dynamic> _$MoveToJson(Move instance) => <String, dynamic>{
      'performedBy': instance.performedBy,
      'sx': instance.sx,
      'sy': instance.sy,
      'ex': instance.ex,
      'ey': instance.ey,
    };
