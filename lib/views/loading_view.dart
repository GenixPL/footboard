import 'package:flutter/material.dart';
import 'package:footboard/widgets/single_scroll_view/single_scroll_view.dart';

class LoadingView extends StatelessWidget {
  const LoadingView();

  @override
  Widget build(BuildContext context) {
    return SingleScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
        ],
      ),
    );
  }
}
