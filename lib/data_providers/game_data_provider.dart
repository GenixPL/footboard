import 'package:footboard/models/game_data.dart';
import 'package:rxdart/rxdart.dart';

class GameDataProvider {
  final BehaviorSubject<GameData?> _gameData$ = BehaviorSubject<GameData?>.seeded(null);

  Stream<GameData?> get connectivityStatusStream {
    return _gameData$.stream;
  }
}
