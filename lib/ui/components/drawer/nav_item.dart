import 'package:flutter/material.dart';

class NavItem {
  final String title;
  final IconData icons;
  final void Function() onTap;

  NavItem(this.title, this.icons, this.onTap);
}
