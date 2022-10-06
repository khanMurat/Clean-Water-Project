import 'package:final_project_ala/core/constants/app_sizes.dart';
import 'package:final_project_ala/core/constants/assets_constants.dart';
import 'package:final_project_ala/core/extensions/context_extension.dart';
import 'package:final_project_ala/features/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late SplashViewModel viewModel;
  final int _duration = 2;

  @override
  void initState() {
    viewModel = SplashViewModel.instance;
    viewModel.init();
    viewModel.setContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SplashViewModel>(
          builder: (BuildContext context, sModel, Widget? child) {
        return AnimatedOpacity(
          opacity: sModel.opacityLevel,
          duration: Duration(seconds: _duration),
          onEnd: sModel.afterSplash,
          child: Center(
            child: Container(
              height: context.heightRate(Sizes.p32),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AssetConstants.splashImg,
                    ),
                    fit: BoxFit.contain),
              ),
            ),
          ),
        );
      }),
    );
  }
}
