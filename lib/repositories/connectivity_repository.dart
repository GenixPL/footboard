import 'package:footboard/data_providers/connectivity_data_provider.dart';
import 'package:footboard/models/connectivity_status.dart';
import 'package:footboard/utils/service_locator.dart';
import 'package:web_socket_channel/io.dart';

class ConnectivityRepository {
  final ConnectivityDataProvider _connectivityDataProvider = sl();

  IOWebSocketChannel? channel;

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

    if (connectivityStatus == ConnectivityStatus.disconnected) {
      channel?.sink.close();
    }

    if (connectivityStatus == ConnectivityStatus.connecting) {
      channel?.sink.close();
      channel = IOWebSocketChannel.connect('ws://localhost:8080/create');

      channel!.stream.listen(
        (dynamic message) {
          print('=== NEW MESSAGE ===');
          print(message);
        },
        onError: (dynamic error) {
          print('== ON ERROR ==');
          print(error);
        },
        onDone: () {
          // Executed when connection gets closed.
          print('== ON DONE ==');
        },
      );
    }

    if (connectivityStatus == ConnectivityStatus.connected) {
      channel?.sink.add('AAA');
    }
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
