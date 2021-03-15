import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footboard/models/connectivity_status.dart';
import 'package:footboard/screens/host/cubit/cubit.dart';
import 'package:footboard/widgets/regular_button/regular_button.dart';
import 'package:footboard/widgets/single_scroll_view/single_scroll_view.dart';

class HostBody extends StatelessWidget {
  const HostBody({
    required this.connectivityStatus,
  });

  final ConnectivityStatus connectivityStatus;

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
          RegularButton(
            text: 'disconnected',
            onTap: () => _onConnectivityTap(context, ConnectivityStatus.disconnected),
          ),
          RegularButton(
            text: 'connecting',
            onTap: () => _onConnectivityTap(context, ConnectivityStatus.connecting),
          ),
          RegularButton(
            text: 'connected',
            onTap: () => _onConnectivityTap(context, ConnectivityStatus.connected),
          ),
          const SizedBox(height: 20.0),
          RegularButton(
            text: 'start',
            onTap: () => _onStartTap(context),
          ),
        ],
      ),
    );
  }

  // FUNCTIONS

  void _onConnectivityTap(BuildContext context, ConnectivityStatus connectivityStatus) {
    context.read<HostScreenCubit>().setConnectivityStatus(connectivityStatus);
  }

  void _onStartTap(BuildContext context) {
    context.read<HostScreenCubit>().startGame();
  }
}
