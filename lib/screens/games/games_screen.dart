import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footboard/utils/path/path_builder.dart';
import 'package:footboard/utils/service_locator.dart';
import 'package:footboard/views/error_view.dart';
import 'package:footboard/views/loading_view.dart';

import 'cubit/cubit.dart';
import 'games_body.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen();

  static const String routeName = 'GamesScreen';

  static MaterialPageRoute<Widget> route() {
    return sl<PathBuilder>().defaultTransition(
      settings: const RouteSettings(name: routeName),
      screen: const GamesScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('games'),
      ),
      body: SafeArea(
        child: BlocProvider<GamesScreenCubit>(
          create: (BuildContext context) => sl()..init(),
          child: BlocBuilder<GamesScreenCubit, GamesScreenState>(
            builder: (BuildContext context, GamesScreenState state) {
              if (state is GamesScreenLoadingState) {
                return const LoadingView();
              } else if (state is GamesScreenLoadedState) {
                return GamesBody(
                  games: state.games,
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
