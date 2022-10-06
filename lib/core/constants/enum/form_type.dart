import 'package:flutter/material.dart';

enum TextForm {
  name((Icons.person), 'Enter your full name'),
  email((Icons.email_outlined), 'Enter your email'),
  visiblePassword((Icons.visibility), 'Enter your password'),
  unvisiblePassword(Icons.visibility_off, 'Enter your password');

  final IconData icon;
  final String label;

  const TextForm(this.icon, this.label);
}
