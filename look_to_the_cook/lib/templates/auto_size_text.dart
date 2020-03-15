import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AutoSizeTextClass extends StatelessWidget{

  final String text;
  final int maxLines;
  final Color textColor;
  final double minFontSize;
  final TextAlign alignment;

  AutoSizeTextClass({@required this.text, this.maxLines, this.textColor, this.minFontSize, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AutoSizeText(
        text,
        maxFontSize: 50.0,
        minFontSize: minFontSize == null ? 13.0 : minFontSize,
        maxLines: maxLines == null ? 10 : maxLines,
        textAlign: alignment == null ? TextAlign.center : alignment,
        style: TextStyle(
            color: textColor == null ? Colors.black : textColor
        ),
      ),
    );
  }
}