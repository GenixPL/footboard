import 'package:equatable/equatable.dart';
import 'package:footboard/models/connectivity_status.dart';

abstract class HostScreenState extends Equatable {
  const HostScreenState();

  @override
  List<Object?> get props => <dynamic>[];
}

class HostScreenLoadingState extends HostScreenState {
  const HostScreenLoadingState();
}

class HostScreenLoadedState extends HostScreenState {
  const HostScreenLoadedState({
    required this.connectivityStatus,
  });

  final ConnectivityStatus connectivityStatus;

  @override
  List<Object?> get props => <dynamic>[
        connectivityStatus,
      ];
}

class HostScreenErrorState extends HostScreenState {
  const HostScreenErrorState({
    required this.errorTitle,
  });

  final String errorTitle;

  @override
  List<Object?> get props => <dynamic>[
        errorTitle,
      ];
}
