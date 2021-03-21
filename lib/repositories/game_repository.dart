import 'package:footboard/data_providers/game_data_provider.dart';
import 'package:footboard/models/connectivity_status.dart';
import 'package:footboard/models/game/game.dart';
import 'package:footboard/utils/service_locator.dart';

class Commands {
  const Commands._();

  static const String occupyPlace = 'occupy_place';
}

class GameRepository {
  final GameDataProvider _gameDataProvider = sl();

  Stream<Game> get gameStream {
    return _gameDataProvider.gameStream;
  }

  Stream<ConnectivityStatus> get connectivityStatus {
    return _gameDataProvider.connectivityStatusStream;
  }

  Future<List<Game>> fetchAvailableGames() {
    return _gameDataProvider.fetchAvailableGames();
  }

  Future<Game?> createNewGame() {
    return _gameDataProvider.createNewGame();
  }

  Future<bool> connectToGame(String gameId) {
    return _gameDataProvider.connectToGame(gameId);
  }

  // Possible place values: 1, 2
  Future<void> occupyPlace(int place) async {
    return _gameDataProvider.sendMsg(<String, dynamic>{
      'command': Commands.occupyPlace,
      'val': place,
    });
  }
}
