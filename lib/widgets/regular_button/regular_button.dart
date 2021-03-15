import 'package:flutter/material.dart';

class RegularButton extends StatelessWidget {
  const RegularButton({
    this.text = '',
    this.onTap,
  });

  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
      ),
    );
  }
}
