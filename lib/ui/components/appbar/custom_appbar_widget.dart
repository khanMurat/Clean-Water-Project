import 'package:final_project_ala/core/constants/enum/app_bar_enum.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({Key? key, required this.appBarEnum})
      : super(
          key: key,
          title: Text(appBarEnum.title),
        );
  final AppBarEnum appBarEnum;
}
