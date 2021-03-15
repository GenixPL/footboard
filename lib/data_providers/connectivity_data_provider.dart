import 'package:footboard/models/connectivity_status.dart';
import 'package:rxdart/rxdart.dart';

class ConnectivityDataProvider {
  final BehaviorSubject<ConnectivityStatus> _connectivityStatus$ =
      BehaviorSubject<ConnectivityStatus>.seeded(ConnectivityStatus.disconnected);

  Stream<ConnectivityStatus> get connectivityStatusStream {
    return _connectivityStatus$.stream;
  }
}
