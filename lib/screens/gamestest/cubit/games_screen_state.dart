import 'package:equatable/equatable.dart';
import 'package:footboard/models/connectivity_status.dart';
import 'package:footboard/models/game/game.dart';

abstract class GamesScreenState extends Equatable {
  const GamesScreenState();

  @override
  List<Object?> get props => <dynamic>[];
}

class GamesScreenLoadingState extends GamesScreenState {
  const GamesScreenLoadingState();
}

class GamesScreenLoadedState extends GamesScreenState {
  const GamesScreenLoadedState({
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

class GamesScreenErrorState extends GamesScreenState {
  const GamesScreenErrorState({
    required this.errorTitle,
  });

  final String errorTitle;

  @override
  List<Object?> get props => <dynamic>[
        errorTitle,
      ];
}
