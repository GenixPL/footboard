import 'package:flutter/material.dart';

class SingleScrollView extends StatelessWidget {
  const SingleScrollView({
    required this.child,
    this.showHorizontalPadding = true,
  });

  static const double padding = 5.0;

  final Widget child;
  final bool showHorizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints boxConstraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: boxConstraints.maxHeight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(showHorizontalPadding ? padding : 0.0),
                    child: child,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
