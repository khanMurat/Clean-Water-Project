import 'package:final_project_ala/core/constants/app_sizes.dart';
import 'package:final_project_ala/core/constants/assets_constants.dart';
import 'package:final_project_ala/core/constants/color_kit.dart';
import 'package:final_project_ala/core/constants/text_constants.dart';
import 'package:final_project_ala/core/extensions/context_extension.dart';
import 'package:final_project_ala/features/welcome/welcome_view_model.dart';
import 'package:final_project_ala/ui/components/button/custom_button.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  WelcomeView({Key? key}) : super(key: key);

  final _model = WelcomeViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorKit.welcomeBgColor,
      body: Column(
        children: [
          Container(
            height: context.heightRate(Sizes.p60),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AssetConstants.welcomeImg),
                  fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Sizes.p12),
            child: Text(AuthConstants.welcomeText,
                style: Theme.of(context).textTheme.titleLarge!),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.p24),
            child: CustomButton(
              text: AuthConstants.loginText,
              horizontal: Sizes.p60,
              onPressed: () => _model.navigateToLogin(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.p24),
            child: CustomButton(
              text: AuthConstants.registerText,
              horizontal: Sizes.p50,
              onPressed: () => _model.navigateToRegister(),
            ),
          )
        ],
      ),
    );
  }
}
