import 'package:json_annotation/json_annotation.dart';

part 'move.g.dart';

@JsonSerializable()
class Move {
  const Move({
    required this.performedBy,
    required this.sx,
    required this.sy,
    required this.ex,
    required this.ey,
  });

  factory Move.fromJson(Map<String, dynamic> json) => _$MoveFromJson(json);

  Map<String, dynamic> toJson() => _$MoveToJson(this);

  final String performedBy;

  final int sx;

  final int sy;

  final int ex;

  final int ey;
}
