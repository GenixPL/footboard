import 'package:equatable/equatable.dart';
import 'package:footboard/models/connectivity_status.dart';
import 'package:footboard/models/game/game.dart';

abstract class GameScreenState extends Equatable {
  const GameScreenState();

  @override
  List<Object?> get props => <dynamic>[];
}

class GameScreenLoadingState extends GameScreenState {
  const GameScreenLoadingState();
}

class GameScreenLoadedState extends GameScreenState {
  const GameScreenLoadedState({
    required this.connectivityStatus,
    required this.game,
  });

  final ConnectivityStatus connectivityStatus;
  final Game? game;

  @override
  List<Object?> get props => <dynamic>[
        connectivityStatus,
        game,
      ];
}

class GameScreenErrorState extends GameScreenState {
  const GameScreenErrorState({
    required this.errorTitle,
  });

  final String errorTitle;

  @override
  List<Object?> get props => <dynamic>[
        errorTitle,
      ];
}
