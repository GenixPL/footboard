import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footboard/utils/path/path_builder.dart';
import 'package:footboard/utils/service_locator.dart';
import 'package:footboard/views/error_view.dart';
import 'package:footboard/views/loading_view.dart';

import 'cubit/cubit.dart';
import 'host_body.dart';

class HostScreen extends StatelessWidget {
  const HostScreen();

  static const String routeName = 'HostScreen';

  static MaterialPageRoute<Widget> route() {
    return sl<PathBuilder>().defaultTransition(
      settings: const RouteSettings(name: routeName),
      screen: const HostScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOST'),
      ),
      body: SafeArea(
        child: BlocProvider<HostScreenCubit>(
          create: (BuildContext context) => sl()..init(),
          child: BlocBuilder<HostScreenCubit, HostScreenState>(
            builder: (BuildContext context, HostScreenState state) {
              if (state is HostScreenLoadingState) {
                return const LoadingView();
              } else if (state is HostScreenLoadedState) {
                return HostBody(
                  connectivityStatus: state.connectivityStatus,
                );
              }

              return ErrorView(
                title: 'Unhandled state: $state',
              );
            },
          ),
        ),
      ),
    );
  }
}
