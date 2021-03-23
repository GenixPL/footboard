import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footboard/models/connectivity_status.dart';
import 'package:footboard/models/game/game.dart';
import 'package:footboard/models/player/player.dart';
import 'package:footboard/screens/game/cubit/cubit.dart';
import 'package:footboard/widgets/regular_button/regular_button.dart';
import 'package:footboard/widgets/single_scroll_view/single_scroll_view.dart';

class GameBody extends StatelessWidget {
  const GameBody({
    required this.connectivityStatus,
    required this.game,
    required this.userId,
  });

  final ConnectivityStatus connectivityStatus;
  final Game game;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return SingleScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildPlayers(context),
          _buildGameState(),
        ],
      ),
    );
  }

  Widget _buildPlayers(BuildContext context) {
    print(userId);
    print(game.player2?.id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'Players',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: game.players.length,
          itemBuilder: (_, int i) {
            final Player player = game.players[i];

            return Text(
              player.id,
              style: TextStyle(
                fontWeight: userId == player.id ? FontWeight.w700 : FontWeight.w500,
              ),
            );
          },
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                '1: ${game.player1?.id}'.replaceAll('', '\u{200B}'),
                style: TextStyle(
                  fontWeight: userId == game.player1?.id ? FontWeight.w700 : FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (game.player1 == null)
              RegularButton(
                text: 'occupy',
                onTap: () => _occupyPlace(context, 1),
              )
            else if (!game.player1!.startedGame)
              RegularButton(
                text: 'start',
                onTap: () => _start(context),
              )
            else
              const RegularButton(
                text: 'started',
                onTap: null,
              ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                '2: ${game.player2?.id}'.replaceAll('', '\u{200B}'),
                style: TextStyle(
                  fontWeight: userId == game.player2?.id ? FontWeight.w700 : FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (game.player2 == null)
              RegularButton(
                text: 'occupy',
                onTap: () => _occupyPlace(context, 2),
              )
            else if (!game.player2!.startedGame)
              RegularButton(
                text: 'start',
                onTap: () => _start(context),
              )
            else
              const RegularButton(
                text: 'started',
                onTap: null,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildGameState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'Game State',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          describeEnum(game.gameState),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // FUNCTIONS

  void _occupyPlace(BuildContext context, int place) {
    context.read<GameScreenCubit>().occupyPlace(place);
  }

  void _start(BuildContext context) {
    context.read<GameScreenCubit>().start();
  }
}
