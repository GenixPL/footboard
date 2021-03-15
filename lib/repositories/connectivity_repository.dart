import 'package:footboard/data_providers/connectivity_data_provider.dart';
import 'package:footboard/models/connectivity_status.dart';
import 'package:footboard/utils/service_locator.dart';

class ConnectivityRepository {
  final ConnectivityDataProvider _connectivityDataProvider = sl();

  Stream<ConnectivityStatus> get connectivityStatusStream {
    return _connectivityDataProvider.connectivityStatusStream;
  }

  Stream<bool?> get isHostStream {
    return _connectivityDataProvider.isHostStream;
  }

  bool? get isHost {
    return _connectivityDataProvider.isHost;
  }

  // TODO(genix): remove
  void setConnectivityStatus(ConnectivityStatus connectivityStatus) {
    _connectivityDataProvider.setConnectivityStatus(connectivityStatus);
  }

  Future<bool> host() async {
    _connectivityDataProvider.setIsHost(true);
    return true;
  }

  Future<bool> connect() async {
    _connectivityDataProvider.setIsHost(false);
    return true;
  }
}
