import 'package:flutter/material.dart';

class ModefiedText extends StatelessWidget {
  ModefiedText({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.maxLines,
    this.overflow,
  });
  final String text;
  Color? color = Colors.white;
  double? size = 18;
  int? maxLines = 1;
  TextOverflow? overflow = TextOverflow.ellipsis;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: size,
      ),
    );
  }
}
