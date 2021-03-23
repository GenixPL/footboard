import 'package:footboard/models/point/point.dart';
import 'package:json_annotation/json_annotation.dart';

part 'move.g.dart';

@JsonSerializable()
class Move {
  const Move({
    required this.performedBy,
    required this.sP,
    required this.eP,
  });

  factory Move.fromJson(Map<String, dynamic> json) => _$MoveFromJson(json);

  Map<String, dynamic> toJson() => _$MoveToJson(this);

  final String performedBy;

  final Point sP;

  final Point eP;
}
