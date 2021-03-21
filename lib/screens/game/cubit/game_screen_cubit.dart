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

    _subscription = CombineLatestStream.combine2(
      _gameRepository.connectivityStatus,
      _gameRepository.gameStream,
      (ConnectivityStatus connectivityStatus, Game? game) {
        emit(GameScreenLoadedState(
          connectivityStatus: connectivityStatus,
          game: game,
        ));
      },
    ).listen((_) {});
  }
}
