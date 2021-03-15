import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footboard/models/connectivity_status.dart';
import 'package:footboard/repositories/connectivity_repository.dart';
import 'package:footboard/screens/game/game_screen.dart';
import 'package:footboard/utils/path/pather.dart';
import 'package:footboard/utils/service_locator.dart';

import 'host_screen_state.dart';

class HostScreenCubit extends Cubit<HostScreenState> {
  HostScreenCubit() : super(const HostScreenLoadingState());

  final ConnectivityRepository _connectivityRepository = sl();
  final Pather _pather = sl();

  StreamSubscription<dynamic>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  // Do all the stuff that needs to be initialized before the app can work.
  Future<void> init() async {
    _subscription = _connectivityRepository.connectivityStatusStream.listen((ConnectivityStatus connectivityStatus) {
      emit(HostScreenLoadedState(
        connectivityStatus: connectivityStatus,
      ));
    });
  }

  void setConnectivityStatus(ConnectivityStatus connectivityStatus) {
    _connectivityRepository.setConnectivityStatus(connectivityStatus);
  }

  Future<void> startGame() async {
    if (state is! HostScreenLoadedState) {
      return;
    }

    if ((state as HostScreenLoadedState).connectivityStatus != ConnectivityStatus.connected) {
      Fluttertoast.showToast(
        msg: 'You have to be connected!',
      );
      return;
    }

    final bool success = await _connectivityRepository.host();
    if (!success) {
      Fluttertoast.showToast(
        msg: "Couldn't host the game!",
      );
      return;
    }

    _pather.push(GameScreen.route());
  }
}
