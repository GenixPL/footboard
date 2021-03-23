import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footboard/models/connectivity_status.dart';
import 'package:footboard/models/game/game.dart';
import 'package:footboard/models/move/move.dart';
import 'package:footboard/models/player/player.dart';
import 'package:footboard/screens/game/cubit/cubit.dart';
import 'package:footboard/widgets/regular_button/regular_button.dart';
import 'package:footboard/widgets/single_scroll_view/single_scroll_view.dart';

class GameBody extends StatelessWidget {
  GameBody({
    required this.connectivityStatus,
    required this.game,
    required this.userId,
  });

  final ConnectivityStatus connectivityStatus;
  final Game game;
  final String userId;

  final TextEditingController _moveX = TextEditingController();
  final TextEditingController _moveY = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildPlayers(context),
          const SizedBox(height: 10.0),
          _buildGameState(),
          const SizedBox(height: 10.0),
          _buildBall(),
          const SizedBox(height: 10.0),
          _buildMoves(context),
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

  Widget _buildBall() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'Ball',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          '(${game.ball.x}, ${game.ball.y})',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildMoves(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Moves',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: TextField(
                    controller: _moveX,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'X',
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: TextField(
                    controller: _moveY,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Y',
                    ),
                  ),
                ),
                RegularButton(
                  text: 'move',
                  onTap: () => _move(context),
                ),
              ],
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: game.moves.length,
          itemBuilder: (_, int i) {
            final Move move = game.moves[i];

            return Text(
              '(${move.sX}, ${move.sY}) -> (${move.eX}, ${move.eY})     ${move.performedBy.substring(0, 4)}',
            );
          },
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

  void _move(BuildContext context) {
    final int? x = int.tryParse(_moveX.text);
    final int? y = int.tryParse(_moveY.text);
    if (x == null || y == null) {
      Fluttertoast.showToast(msg: 'Both inputs have to be ints.');
      return;
    }

    context.read<GameScreenCubit>().move(x, y);
  }
}
