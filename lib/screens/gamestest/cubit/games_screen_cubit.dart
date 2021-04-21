import 'package:bloc/bloc.dart';
import 'package:footboard/models/game/game.dart';
import 'package:footboard/repositories/game_repository.dart';
import 'package:footboard/utils/path/pather.dart';
import 'package:footboard/utils/service_locator.dart';

import 'games_screen_state.dart';

class GamesScreenTestCubit extends Cubit<GamesScreenState> {
  GamesScreenTestCubit() : super(const GamesScreenLoadingState());

  final GameRepository _gameRepository = sl();
  final Pather _pather = sl();

  Future<void> init() async {
    // final List<Game> games = await _gameRepository.fetchAvailableGames();

    emit(GamesScreenLoadedState(
      games: [],
    ));
  }
}
