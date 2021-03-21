import 'package:json_annotation/json_annotation.dart';

part 'ball.g.dart';

@JsonSerializable()
class Ball {
  const Ball({
    required this.x,
    required this.y,
  });

  factory Ball.fromJson(Map<String, dynamic> json) => _$BallFromJson(json);

  Map<String, dynamic> toJson() => _$BallToJson(this);

  final int x;

  final int y;
}
