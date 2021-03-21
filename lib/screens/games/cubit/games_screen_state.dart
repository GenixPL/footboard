import 'package:equatable/equatable.dart';
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
    required this.games,
  });

  final List<Game> games;

  @override
  List<Object?> get props => <dynamic>[
        games,
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
