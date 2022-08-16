import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

//亀井さんの言うところの「SqKey」
class SquareButton extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onLongTap;
  final IconData? icon;
  final String? label;
  final String? font;
  final int line;
  final double? width;
  final double height;
  final double? fontSize;
  final double padding;
  final Color color;
  final Color? fontColor;

  SquareButton(
      {this.label,
      this.font,
      this.icon,
      this.line = 1,
      this.width,
      this.height = 40,
      this.fontSize = 48,
      this.padding = 0,
      this.color = Colors.blue,
      this.fontColor,
      this.onLongTap,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: width != null ? width : height,
        height: height,
        decoration: (color == Colors.transparent)
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(5.6),
                border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 2.4,
                    style: BorderStyle.solid))
            : null,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(padding),
                onPrimary: fontColor ??
                    Colors.white
                        .withOpacity((color == Colors.transparent) ? 0.5 : 1),
                primary: color,
                elevation: 0.0),
            child: (icon != null)
                ? Icon(icon)
                : AutoSizeText(label ?? "",
                    style: TextStyle(
                        height: 1, fontFamily: font, fontSize: fontSize),
                    maxLines: line,
                    minFontSize: 1,
                    textAlign: TextAlign.center),
            onLongPress: onLongTap,
            onPressed: onTap),
      ),
    );
  }
}
