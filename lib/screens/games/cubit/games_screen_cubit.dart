import 'package:bloc/bloc.dart';
import 'package:footboard/models/game/game.dart';
import 'package:footboard/repositories/game_repository.dart';
import 'package:footboard/utils/service_locator.dart';

import 'games_screen_state.dart';

class GamesScreenCubit extends Cubit<GamesScreenState> {
  GamesScreenCubit() : super(const GamesScreenLoadingState());

  final GameRepository _gameRepository = sl();

  Future<void> init() async {
    final List<Game> games = await _gameRepository.fetchAvailableGames();

    emit(GamesScreenLoadedState(
      games: games,
    ));
  }

  Future<void> connectToGame(String gameId) async {
    await _gameRepository.connectToGame(gameId);
  }
}
