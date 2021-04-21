import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footboard/utils/path/path_builder.dart';
import 'package:footboard/utils/service_locator.dart';
import 'package:footboard/views/error_view.dart';
import 'package:footboard/views/loading_view.dart';

import 'cubit/cubit.dart';
import 'games_body.dart';

class GamesScreenTest extends StatelessWidget {
  const GamesScreenTest({
    required this.gameId,
  });

  final String gameId;

  static const String routeName = 'GamesScreenTest';

  static MaterialPageRoute<Widget> route({
    required String gameId,
  }) {
    return sl<PathBuilder>().defaultTransition(
      settings: const RouteSettings(name: routeName),
      screen: GamesScreenTest(
        gameId: gameId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('games'),
      ),
      body: SafeArea(
        child: BlocProvider<GamesScreenTestCubit>(
          create: (BuildContext context) => sl()..init(gameId),
          child: BlocBuilder<GamesScreenTestCubit, GamesScreenState>(
            builder: (BuildContext context, GamesScreenState state) {
              if (state is GamesScreenLoadingState) {
                return const LoadingView();
              } else if (state is GamesScreenLoadedState) {
                return GamesBody(
                  game: state.game,
                  userId: state.userId,
                );
              } else if (state is GamesScreenErrorState) {
                return ErrorView(
                  title: state.errorTitle,
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
