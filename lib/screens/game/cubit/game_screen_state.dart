import 'package:equatable/equatable.dart';
import 'package:footboard/models/connectivity_status.dart';

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
    required this.isHost,
  });

  final ConnectivityStatus connectivityStatus;
  final bool isHost;

  @override
  List<Object?> get props => <dynamic>[
        connectivityStatus,
        isHost,
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
