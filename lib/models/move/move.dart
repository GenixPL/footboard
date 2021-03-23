import 'package:json_annotation/json_annotation.dart';

part 'move.g.dart';

@JsonSerializable()
class Move {
  const Move({
    required this.performedBy,
    required this.sX,
    required this.sY,
    required this.eX,
    required this.eY,
  });

  factory Move.fromJson(Map<String, dynamic> json) => _$MoveFromJson(json);

  Map<String, dynamic> toJson() => _$MoveToJson(this);

  final String performedBy;

  final int sX;

  final int sY;

  final int eX;

  final int eY;
}
