import 'dart:convert';

import 'package:footboard/models/connectivity_status.dart';
import 'package:footboard/models/game/game.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';

const String _getGamesUrl = 'http://localhost:8080/games';
const String _createGameUrl = 'http://localhost:8080/create-new-game';
const String _connectToGameUrl = 'ws://localhost:8080/connect/';

class GameDataProvider {
  final BehaviorSubject<Game?> _game$ = BehaviorSubject<Game?>.seeded(null);
  final BehaviorSubject<ConnectivityStatus> _connectivityStatus$ =
      BehaviorSubject<ConnectivityStatus>.seeded(ConnectivityStatus.disconnected);

  IOWebSocketChannel? _channel;

  Stream<ConnectivityStatus> get connectivityStatusStream {
    return _connectivityStatus$.stream;
  }

  Stream<Game?> get gameStream {
    return _game$.stream;
  }

  Future<List<Game>> fetchAvailableGames() async {
    print('Fetching games...');

    final http.Response response = await http.get(Uri.parse(_getGamesUrl));

    final List<Game> games = <Game>[];

    try {
      final List<dynamic> responseJson = jsonDecode(response.body);
      for (dynamic gameMap in responseJson) {
        games.add(Game.fromJson(gameMap));
      }
    } catch (e) {
      print("Couldn't parse response, error: $e");
    }

    return games;
  }

  Future<Game?> createNewGame() async {
    print('Creating new game...');

    final http.Response response = await http.get(Uri.parse(_createGameUrl));

    try {
      return Game.fromJson(jsonDecode(response.body));
    } catch (e) {
      print("Couldn't parse response, error: $e");
      return null;
    }
  }

  Future<bool> connectToGame(String gameId) async {
    if (_channel != null) {
      await disconnect();
    }

    _channel = IOWebSocketChannel.connect(_connectToGameUrl + gameId);

    final Stream<dynamic> stream = _channel!.stream.asBroadcastStream();

    final String response = await stream.first;
    final Map<String, dynamic> responseMap = jsonDecode(response);
    if (responseMap["error"] != null) {
      await _clearChannel();
      return false;
    }

    _onMessage(jsonEncode(responseMap["newGame"]));

    stream.listen(
      _onMessage,
      onError: _onError,
      onDone: _onDone,
    );

    return true;
  }

  Future<bool> disconnect() async {
    if (_connectivityStatus$.value == ConnectivityStatus.disconnected || _channel == null) {
      return true;
    }

    await _clearChannel();
    return true;
  }

  // PRIVATE

  void _onMessage(dynamic message) {
    print('=== NEW MESSAGE ===');

    Game game;
    try {
      game = Game.fromJson(jsonDecode(message));
    } catch (e) {
      print("Couldn't parse message, error: $e");
      return;
    }

    _game$.add(game);
  }

  void _onError(dynamic error) {
    print('== ON ERROR ==');
    print(error);

    _clearChannel();
  }

  // Executed when connection is closed.
  void _onDone() {
    print('== ON DONE ==');

    _clearChannel();
  }

  Future<void> _clearChannel() async {
    await _channel?.sink.close();
    _channel = null;
    _connectivityStatus$.add(ConnectivityStatus.disconnected);
  }
}
