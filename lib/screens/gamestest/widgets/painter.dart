import 'dart:math';

import 'package:flutter/material.dart';

class BoardSpecs {
  BoardSpecs({
    required Size size,
  }) {
    final maxWidth = size.width - 2 * offset;
    final maxHeight = size.height - 2 * offset;
    grid = min(maxWidth / boardWidth, maxHeight / boardHeight);
    width = grid * boardWidth;
    height = grid * boardHeight;
    horOffset = (size.width - width) / 2;
    vertOffset = (size.height - height) / 2;
    bounds = Rect.fromLTWH(horOffset, vertOffset, width, height);
  }

  final offset = 20.0;
  final boardWidth = 8;
  final boardHeight = 12;
  late double grid, width, height;
  late double horOffset, vertOffset;
  late Rect bounds;

  /// Takes a board point, e.g. (1,2), and returns a point with
  /// absolute coordinates
  Point getAbsoluteCoordinates(Point move) {
    return Point(move.x * grid + bounds.center.dx, move.y * grid + bounds.center.dy);
  }

  Point<int> shiftToCenter(Point<int> point) {
    return Point<int>(
      (point.x - boardWidth / 2).toInt(),
      (point.y - boardHeight / 2).toInt(),
    );
  }

  bool isOnBorder(Point point) {
    return point.x.abs() == boardWidth / 2 || point.y.abs() == boardHeight / 2;
  }

  /// Returns:
  /// 0 - if the game isn't over
  /// 1 - if player 1 has won
  /// 2 - if player 2 has won
  int isGameOver(Point point) {
    if (point.x.abs() == 1 || point.x == 0) {
      if (point.y == -boardHeight / 2) {
        return 1;
      } else if (point.y == boardHeight / 2) {
        return 2;
      }
    }
    return 0;
  }
}

class BoardBackground extends CustomPainter {
  BoardBackground({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final specs = BoardSpecs(size: size);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke;

    final goalWidth = 2 * specs.grid;
    final goalHeight = specs.grid;
    final horGoalDistance = (specs.bounds.width - goalWidth) / 2;

    final outlinePath = Path()
      ..moveTo(specs.bounds.left, specs.bounds.top + goalHeight)
      ..lineTo(specs.bounds.left + horGoalDistance, specs.bounds.top + goalHeight)
      ..lineTo(specs.bounds.left + horGoalDistance, specs.bounds.top)
      ..lineTo(specs.bounds.left + horGoalDistance + goalWidth, specs.bounds.top)
      ..lineTo(specs.bounds.left + horGoalDistance + goalWidth, specs.bounds.top + goalHeight)
      ..lineTo(specs.bounds.right, specs.bounds.top + goalHeight)
      ..lineTo(specs.bounds.right, specs.bounds.bottom - goalHeight)
      ..lineTo(specs.bounds.right - horGoalDistance, specs.bounds.bottom - goalHeight)
      ..lineTo(specs.bounds.right - horGoalDistance, specs.bounds.bottom)
      ..lineTo(specs.bounds.right - horGoalDistance - goalWidth, specs.bounds.bottom)
      ..lineTo(specs.bounds.right - horGoalDistance - goalWidth, specs.bounds.bottom - goalHeight)
      ..lineTo(specs.bounds.left, specs.bounds.bottom - goalHeight)
      ..close();

    canvas.drawPath(outlinePath, paint);

    paint.style = PaintingStyle.fill;
    canvas.drawCircle(specs.bounds.center, 2, paint);

    for (var i = specs.bounds.left + specs.grid; i < specs.bounds.right; i += specs.grid) {
      for (var j = specs.bounds.top + 2 * specs.grid; j < specs.bounds.bottom - specs.grid; j += specs.grid) {
        canvas.drawCircle(Offset(i, j), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(BoardBackground oldDelegate) => false;
}

class BoardForeground extends CustomPainter {
  BoardForeground({required this.moves});

  final Color color = Colors.white;
  final List<Point> moves;

  @override
  void paint(Canvas canvas, Size size) {
    final specs = BoardSpecs(size: size);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke;

    final path = Path()..moveTo(specs.bounds.center.dx, specs.bounds.center.dy);

    for (var move in moves) {
      move = specs.getAbsoluteCoordinates(move);
      path.lineTo(move.x.toDouble(), move.y.toDouble());
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BoardForeground oldDelegate) {
    return oldDelegate.moves.length != moves.length;
  }
}
