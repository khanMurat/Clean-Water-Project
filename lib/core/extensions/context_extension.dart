import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get queryData => MediaQuery.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension MediaQueryExtension on BuildContext {
  Size get size => queryData.size;

  double get height => size.height;

  double get width => size.width;

  double heightRate(double rate) => (height * rate) / 100;

  double widthRate(double rate) => (width * rate) / 100;
}
