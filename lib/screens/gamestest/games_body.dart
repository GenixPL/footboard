import 'dart:math';

import 'package:flutter/material.dart';
import 'package:footboard/screens/gamestest/widgets/painter.dart';

class GamesBody extends StatefulWidget {
  const GamesBody();

  @override
  _GamesBodyState createState() => _GamesBodyState();
}

class _GamesBodyState extends State<GamesBody> {
  late Size canvasSize;
  List<Point> moves = [Point(0, 0)];
  int player = 1;
  var resultString = '';
  var gameOver = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Player $player $resultString'),
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
                              foregroundPainter:
                                  BoardForeground(moves: moves.toList()),
                            ),
                            onTapDown: (details) =>
                                setState(() => addMove(details)),
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
    if (gameOver) {
      gameOver = false;
      moves = [Point(0, 0)];
      resultString = '';
    }

    final specs = BoardSpecs(size: canvasSize);
    final x = (tapPoint.localPosition.dx / specs.grid).floor();
    final y = (tapPoint.localPosition.dy / specs.grid).floor();
    final point = specs.shiftToCenter(Point(x, y));

    if (!isValidMove(point)) {
      print('Invalid');
      return;
    }
    print('Valid');

    moves.add(point);
    print(moves);

    final gameResult = specs.isGameOver(moves.last);
    if (gameResult != 0) {
      player = gameResult;
      resultString = 'won';
      gameOver = true;
    }
    if (shouldEndTurn(specs)){
      nextPlayer();
    }
  }

  // Returns true if the new move is valid
  bool isValidMove(Point move) {
    if (moves.isEmpty) return true;
    if (move == moves.last) return false;

    final validDistance = (move.x - moves.last.x).abs() <= 1 &&
        (move.y - moves.last.y).abs() <= 1;
    if (!validDistance) return false;

    // Check if we have covered this exact line
    for (var i = 0; i < moves.length - 1; i++) {
      final duplicateLine = (move == moves[i] && moves.last == moves[i + 1]) ||
          (move == moves[i + 1] && moves.last == moves[i]);
      if (duplicateLine) return false;
    }
    return true;
  }

  bool shouldEndTurn(BoardSpecs specs){
    // Can the ball bounce off drawn lines
    if (moves.sublist(0, moves.length-1).contains(moves.last)) {
      return false;
    }
    return !specs.isOnBorder(moves.last);
  }

  void nextPlayer() {
    setState(() {
      if (player == 1) {
        player = 2;
      } else {
        player = 1;
      }
    });
  }
}
