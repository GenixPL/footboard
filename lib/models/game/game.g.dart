// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) {
  return Game(
    id: json['id'] as String,
    players: (json['clients'] as List<dynamic>)
        .map((e) => Player.fromJson(e as Map<String, dynamic>))
        .toList(),
    player1: json['player1'] == null
        ? null
        : Player.fromJson(json['player1'] as Map<String, dynamic>),
    player2: json['player2'] == null
        ? null
        : Player.fromJson(json['player2'] as Map<String, dynamic>),
    movesPlayer1: json['movesPlayer1'] as bool,
    ball: Point.fromJson(json['ball'] as Map<String, dynamic>),
    moves: (json['moves'] as List<dynamic>)
        .map((e) => Move.fromJson(e as Map<String, dynamic>))
        .toList(),
    gameState: _$enumDecode(_$GameStateEnumMap, json['gameState']),
  );
}

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': instance.id,
      'clients': instance.players,
      'player1': instance.player1,
      'player2': instance.player2,
      'movesPlayer1': instance.movesPlayer1,
      'ball': instance.ball,
      'moves': instance.moves,
      'gameState': _$GameStateEnumMap[instance.gameState],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$GameStateEnumMap = {
  GameState.waiting_for_players: 'waiting_for_players',
  GameState.has_one_player: 'has_one_player',
  GameState.has_two_players: 'has_two_players',
  GameState.one_player_started: 'one_player_started',
  GameState.running: 'running',
  GameState.paused: 'paused',
  GameState.first_player_won: 'first_player_won',
  GameState.second_player_won: 'second_player_won',
};
