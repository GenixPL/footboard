import 'package:flutter/material.dart';
import 'package:footboard/screens/games/games_screen.dart';
import 'package:footboard/screens/gamestest/games_screen.dart';
import 'package:footboard/utils/path/pather.dart';
import 'package:footboard/utils/service_locator.dart';
import 'package:footboard/widgets/regular_button/regular_button.dart';
import 'package:footboard/widgets/single_scroll_view/single_scroll_view.dart';

class HomeBody extends StatelessWidget {
  const HomeBody();

  @override
  Widget build(BuildContext context) {
    return SingleScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            'footboard',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 20.0),
          RegularButton(
            text: 'GAMES',
            onTap: () => sl<Pather>().push(GamesScreen.route()),
          ),
        ],
      ),
    );
  }
}
