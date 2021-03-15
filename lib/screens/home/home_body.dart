import 'package:flutter/material.dart';
import 'package:footboard/widgets/single_scroll_view/single_scroll_view.dart';

class HomeBody extends StatelessWidget {
  const HomeBody();

  @override
  Widget build(BuildContext context) {
    return SingleScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Text(
            'footboard',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
