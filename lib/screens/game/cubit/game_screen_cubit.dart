import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:footboard/models/connectivity_status.dart';
import 'package:footboard/repositories/connectivity_repository.dart';
import 'package:footboard/utils/service_locator.dart';

import 'game_screen_state.dart';

class GameScreenCubit extends Cubit<GameScreenState> {
  GameScreenCubit() : super(const GameScreenLoadingState());

  final ConnectivityRepository _connectivityRepository = sl();

  StreamSubscription<dynamic>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  // Do all the stuff that needs to be initialized before the app can work.
  Future<void> init() async {
    final bool isHost = _connectivityRepository.isHost!;

    _subscription = _connectivityRepository.connectivityStatusStream.listen((ConnectivityStatus connectivityStatus) {
      emit(GameScreenLoadedState(
        connectivityStatus: connectivityStatus,
        isHost: isHost,
      ));
    });
  }
}
