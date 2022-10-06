import 'package:flutter/material.dart';

class CustomSnackBar {
  BuildContext context;

  CustomSnackBar(this.context);

  void showSnackBar(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: color,
      ),
    );
  }
}
