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
  });

  final ConnectivityStatus connectivityStatus;
  final Game game;

  @override
  Widget build(BuildContext context) {
    return SingleScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildPlayers(context),
        ],
      ),
    );
  }

  Widget _buildPlayers(BuildContext context) {
    return Column(
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

            return Text(player.id);
          },
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                '1: ${game.player1?.id}'.replaceAll('', '\u{200B}'),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            RegularButton(
              text: 'occupy',
              onTap: () => _occupyPlace(context, 1),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                '2: ${game.player2?.id}'.replaceAll('', '\u{200B}'),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            RegularButton(
              text: 'occupy',
              onTap: () => _occupyPlace(context, 2),
            ),
          ],
        ),
      ],
    );
  }

  // FUNCTIONS

  void _occupyPlace(BuildContext context, int place) {
    context.read<GameScreenCubit>().occupyPlace(place);
  }
}
