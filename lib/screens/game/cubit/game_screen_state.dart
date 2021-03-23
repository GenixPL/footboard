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
    required this.userId,
  });

  final ConnectivityStatus connectivityStatus;
  final Game game;
  final String userId;

  @override
  List<Object?> get props => <dynamic>[
        connectivityStatus,
        game,
        userId,
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
