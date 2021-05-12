import 'package:flutter/cupertino.dart';

  class MyTextStyle extends TextStyle {
  final Color color;
  final FontWeight fontWeight;
  final double size;
  final String fontFamily;

  const MyTextStyle({
      @required this.color,
      @required this.fontWeight,
      this.size = 14,
      this.fontFamily = 'Montserrat',
  })  : assert(color != null && fontWeight != null),
  super(
    color: color,
    fontWeight: fontWeight,
    fontSize: size,
    fontFamily: fontFamily,
  );
}
 // stolen from stackoverflow