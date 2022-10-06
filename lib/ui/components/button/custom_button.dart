import 'package:final_project_ala/core/constants/app_sizes.dart';
import 'package:final_project_ala/core/constants/color_kit.dart';
import 'package:final_project_ala/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.horizontal,
    this.onPressed,
  }) : super(key: key);

  final String? text;
  final double horizontal;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: Sizes.p16),
        child: Text(
          text!,
          style: context.textTheme.titleSmall!
              .copyWith(color: ColorKit.whiteColor),
        ),
      ),
    );
  }
}
