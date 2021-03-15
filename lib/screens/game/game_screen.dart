import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footboard/utils/path/path_builder.dart';
import 'package:footboard/utils/service_locator.dart';
import 'package:footboard/views/error_view.dart';
import 'package:footboard/views/loading_view.dart';

import 'cubit/cubit.dart';
import 'game_body.dart';

class GameScreen extends StatelessWidget {
  const GameScreen();

  static const String routeName = 'GameScreen';

  static MaterialPageRoute<Widget> route() {
    return sl<PathBuilder>().defaultTransition(
      settings: const RouteSettings(name: routeName),
      screen: const GameScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('GAME'),
      ),
      body: SafeArea(
        child: BlocProvider<GameScreenCubit>(
          create: (BuildContext context) => sl()..init(),
          child: BlocBuilder<GameScreenCubit, GameScreenState>(
            builder: (BuildContext context, GameScreenState state) {
              if (state is GameScreenLoadingState) {
                return const LoadingView();
              } else if (state is GameScreenLoadedState) {
                return GameBody(
                  connectivityStatus: state.connectivityStatus,
                  isHost: state.isHost,
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
