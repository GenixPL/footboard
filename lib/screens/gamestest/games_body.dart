import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footboard/models/game/game.dart';
import 'package:footboard/models/game_state.dart';
import 'package:footboard/screens/gamestest/widgets/painter.dart';
import 'package:footboard/widgets/regular_button/regular_button.dart';

import 'cubit/games_screen_cubit.dart';

class GamesBody extends StatefulWidget {
  const GamesBody({
    required this.game,
    required this.userId,
  });

  final Game game;
  final String userId;

  @override
  _GamesBodyState createState() => _GamesBodyState();
}

class _GamesBodyState extends State<GamesBody> {
  late Size canvasSize;

  @override
  Widget build(BuildContext context) {
    final bool isPlayer1 = widget.game.player1?.id == widget.userId;
    final bool isMoving = (widget.game.movesPlayer1 && isPlayer1) || (!widget.game.movesPlayer1 && !isPlayer1);

    return Center(
      child: Column(
        children: [
          if (widget.game.gameState != GameState.running)
            Row(
              children: [
                RegularButton(
                  text: 'ready',
                  onTap: () => context.read<GamesScreenTestCubit>().start(),
                ),
                RegularButton(
                  text: 'place 1',
                  onTap: () => context.read<GamesScreenTestCubit>().occupyPlace(1),
                ),
                RegularButton(
                  text: 'place 2',
                  onTap: () => context.read<GamesScreenTestCubit>().occupyPlace(2),
                ),
              ],
            ),
          Text(isMoving ? 'Your turn!' : 'not your turn'),
          const SizedBox(height: 10.0),
          Text('Game state: ${widget.game.gameState}'),
          const SizedBox(height: 10.0),
          Expanded(
            child: Container(
              color: Colors.green,
              alignment: Alignment.center,
              child: Center(
                child: Stack(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        canvasSize = constraints.biggest;

                        return SizedBox(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          child: GestureDetector(
                            child: CustomPaint(
                              painter: BoardBackground(color: Colors.white),
                              foregroundPainter: BoardForeground(
                                moves: widget.game.movesAsPoints,
                              ),
                            ),
                            onTapDown: (details) => addMove(details),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addMove(TapDownDetails tapPoint) {
    final BoardSpecs specs = BoardSpecs(size: canvasSize);
    final int x = ((tapPoint.localPosition.dx - specs.horOffset) / specs.grid).floor();
    final int y = ((tapPoint.localPosition.dy - specs.vertOffset) / specs.grid).floor();
    final Point<int> point = specs.shiftToCenter(Point<int>(x, y));

    print('=========== SHIFTING =========');
    print('tap x: ${tapPoint.localPosition.dx}, tap y: ${tapPoint.localPosition.dy}');
    print('grid: ${specs.grid}, width: ${specs.width}, height: ${specs.height}');
    print('produced x: $x, produced: $y');
    print('=========== =========');

    if (!widget.game.canPerformMove(point)) {
      Fluttertoast.showToast(
        msg: 'Invalid move',
      );
      return;
    }

    context.read<GamesScreenTestCubit>().move(point.x, point.y);
  }
}
