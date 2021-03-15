import 'package:footboard/models/connectivity_status.dart';
import 'package:rxdart/rxdart.dart';

class ConnectivityDataProvider {
  final BehaviorSubject<ConnectivityStatus> _connectivityStatus$ =
      BehaviorSubject<ConnectivityStatus>.seeded(ConnectivityStatus.disconnected);

  final BehaviorSubject<bool?> _isHost$ = BehaviorSubject<bool?>.seeded(null);

  Stream<ConnectivityStatus> get connectivityStatusStream {
    return _connectivityStatus$.stream;
  }

  Stream<bool?> get isHostStream {
    return _isHost$.stream;
  }

  bool? get isHost {
    return _isHost$.value;
  }

  void setConnectivityStatus(ConnectivityStatus connectivityStatus) {
    _connectivityStatus$.add(connectivityStatus);
  }

  void setIsHost(bool? isHost) {
    _isHost$.add(isHost);
  }
}
