import 'package:flutter/material.dart';

class Textdata extends StatelessWidget {
  final String text;
  final double? fontsize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  const Textdata({
    Key? key,
    required this.text,
    this.fontsize,
    this.textColor,
    this.fontWeight,
    this.fontStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontsize,
          color: textColor,
          fontWeight: fontWeight,
          fontStyle: fontStyle),
    );
  }
}
