import 'package:footboard/models/ball/ball.dart';
import 'package:footboard/models/game_state.dart';
import 'package:footboard/models/move/move.dart';
import 'package:footboard/models/player/player.dart';
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
  });

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);

  final String id;

  @JsonKey(name: 'clients')
  final List<Player> players;

  final Player? player1;

  final Player? player2;

  final bool movesPlayer1;

  final Ball ball;

  final List<Move> moves;

  final GameState gameState;
}
