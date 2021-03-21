import 'package:flutter/material.dart';
import 'package:footboard/models/game/game.dart';
import 'package:footboard/widgets/single_scroll_view/single_scroll_view.dart';

class GamesBody extends StatelessWidget {
  const GamesBody({
    required this.games,
  });

  final List<Game> games;

  @override
  Widget build(BuildContext context) {
    return SingleScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
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
        ],
      ),
    );
  }

  void _onGameTap(BuildContext context, Game game) {

  }
}
