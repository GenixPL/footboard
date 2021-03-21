import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footboard/models/game/game.dart';
import 'package:footboard/screens/games/cubit/cubit.dart';
import 'package:footboard/widgets/regular_button/regular_button.dart';

class GamesBody extends StatelessWidget {
  const GamesBody({
    required this.games,
  });

  final List<Game> games;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: games.length,
            itemBuilder: (_, int i) => GestureDetector(
              onTap: () => _onGameTap(context, games[i]),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(games[i].id),
                ),
              ),
            ),
          ),
        ),
        RegularButton(
          text: 'create',
          onTap: () => _onCreateTap(context),
        ),
      ],
    );
  }

  void _onGameTap(BuildContext context, Game game) {
    context.read<GamesScreenCubit>().connectToGame(game.id);
  }

  void _onCreateTap(BuildContext context) {
    context.read<GamesScreenCubit>().createNewGame();
  }
}
