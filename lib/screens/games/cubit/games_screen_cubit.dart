import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footboard/models/game/game.dart';
import 'package:footboard/repositories/game_repository.dart';
import 'package:footboard/screens/gamestest/games_screen.dart';
import 'package:footboard/utils/path/pather.dart';
import 'package:footboard/utils/service_locator.dart';

import 'games_screen_state.dart';

class GamesScreenCubit extends Cubit<GamesScreenState> {
  GamesScreenCubit() : super(const GamesScreenLoadingState());

  final GameRepository _gameRepository = sl();
  final Pather _pather = sl();

  Future<void> init() async {
    final List<Game> games = await _gameRepository.fetchAvailableGames();

    emit(GamesScreenLoadedState(
      games: games,
    ));
  }

  Future<void> connectToGame(String gameId) async {
    _pather.push(GamesScreenTest.route(gameId: gameId));
  }

  Future<void> createNewGame() async {
    final Game? newGame = await _gameRepository.createNewGame();

    if (newGame == null) {
      Fluttertoast.showToast(
        msg: "Couldn't create new game!",
      );
      return;
    }

    final List<Game> games = await _gameRepository.fetchAvailableGames();

    emit(GamesScreenLoadedState(
      games: games,
    ));

    _pather.push(GamesScreenTest.route(gameId: newGame.id));
  }
}
