import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:footboard/models/connectivity_status.dart';
import 'package:footboard/widgets/single_scroll_view/single_scroll_view.dart';

class GameBody extends StatelessWidget {
  const GameBody({
    required this.connectivityStatus,
    required this.isHost,
  });

  final ConnectivityStatus connectivityStatus;
  final bool isHost;

  @override
  Widget build(BuildContext context) {
    return SingleScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text('Connectivity status:'),
          Text(describeEnum(connectivityStatus)),
          const SizedBox(height: 20.0),
          const Text('Is host:'),
          Text(isHost.toString()),
        ],
      ),
    );
  }
}
