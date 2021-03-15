import 'package:equatable/equatable.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object?> get props => <dynamic>[];
}

class HomeScreenLoadingState extends HomeScreenState {
  const HomeScreenLoadingState();
}

class HomeScreenLoadedState extends HomeScreenState {
  const HomeScreenLoadedState();
}

class HomeScreenErrorState extends HomeScreenState {
  const HomeScreenErrorState({
    required this.errorTitle,
  });

  final String errorTitle;

  @override
  List<Object?> get props => <dynamic>[
        errorTitle,
      ];
}
