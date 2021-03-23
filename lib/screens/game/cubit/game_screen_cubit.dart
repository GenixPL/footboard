import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:footboard/models/connectivity_status.dart';
import 'package:footboard/models/game/game.dart';
import 'package:footboard/repositories/game_repository.dart';
import 'package:footboard/utils/service_locator.dart';
import 'package:rxdart/rxdart.dart';

import 'game_screen_state.dart';

class GameScreenCubit extends Cubit<GameScreenState> {
  GameScreenCubit() : super(const GameScreenLoadingState());

  final GameRepository _gameRepository = sl();

  StreamSubscription<dynamic>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    _gameRepository.disconnect();

    return super.close();
  }

  // Do all the stuff that needs to be initialized before the app can work.
  Future<void> init(String gameId) async {
    final bool success = await _gameRepository.connectToGame(gameId);
    if (!success) {
      emit(const GameScreenErrorState(
        errorTitle: "Couldn't connect!",
      ));
      return;
    }

    _subscription = CombineLatestStream.combine3(
      _gameRepository.connectivityStatus,
      _gameRepository.gameStream,
      _gameRepository.userIdStream,
      (ConnectivityStatus connectivityStatus, Game game, String userId) {
        emit(GameScreenLoadedState(
          connectivityStatus: connectivityStatus,
          game: game,
          userId: userId,
        ));
      },
    ).listen((_) {});
  }

  Future<void> occupyPlace(int place) async {
    await _gameRepository.occupyPlace(place);
  }

  Future<void> start() async {
    await _gameRepository.start();
  }

  Future<void> move(int x, int y) async {
    await _gameRepository.move(x, y);
  }
}
