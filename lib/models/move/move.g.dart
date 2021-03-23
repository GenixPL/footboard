// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Move _$MoveFromJson(Map<String, dynamic> json) {
  return Move(
    performedBy: json['performedBy'] as String,
    sP: Point.fromJson(json['sP'] as Map<String, dynamic>),
    eP: Point.fromJson(json['eP'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MoveToJson(Move instance) => <String, dynamic>{
      'performedBy': instance.performedBy,
      'sP': instance.sP,
      'eP': instance.eP,
    };
