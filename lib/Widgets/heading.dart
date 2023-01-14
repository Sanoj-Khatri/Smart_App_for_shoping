import 'package:flutter/material.dart';

class HeadingTet extends StatelessWidget {
  final String text;

  const HeadingTet({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
          color: Colors.purple,
          fontStyle: FontStyle.italic),
    );
  }
}
