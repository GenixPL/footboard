import 'package:flutter/material.dart';
import 'package:footboard/widgets/single_scroll_view/single_scroll_view.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.title,
    this.description,
  });

  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return SingleScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          if (description != null)
            Text(
              description!,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
