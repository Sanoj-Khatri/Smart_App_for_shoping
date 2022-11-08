import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  final String text;

  const HeadingText({
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
