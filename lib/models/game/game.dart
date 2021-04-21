import 'dart:math' as math;

import 'package:footboard/models/game_state.dart';
import 'package:footboard/models/move/move.dart';
import 'package:footboard/models/player/player.dart';
import 'package:footboard/models/point/point.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game.g.dart';

@JsonSerializable()
class Game {
  const Game({
    required this.id,
    required this.players,
    required this.player1,
    required this.player2,
    required this.movesPlayer1,
    required this.ball,
    required this.moves,
    required this.gameState,
    required this.possiblePoints,
  });

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);

  final String id;

  @JsonKey(name: 'clients')
  final List<Player> players;

  final Player? player1;

  final Player? player2;

  final bool movesPlayer1;

  final Point ball;

  final List<Move> moves;

  final List<Point> possiblePoints;

  final GameState gameState;

  List<math.Point<int>> get movesAsPoints {
    final List<math.Point<int>> points = <math.Point<int>>[];

    points.add(const math.Point<int>(0, 0));

    print('===== performed moves =====');
    for (Move move in moves) {
      print(math.Point<int>(move.eP.x, move.eP.y));
      points.add(math.Point<int>(move.eP.x, move.eP.y));
    }

    return points;
  }

  bool canPerformMove(math.Point<int> point) {
    print('0000000000');
    print('point: $point');
    print('possible points:');

    for (Point p in possiblePoints) {
      print('point: ${p.x} ${p.y}');
      if (p.x == point.x && p.y == point.y) {
        return true;
      }
    }

    print('0000000000');

    return false;
  }
}
