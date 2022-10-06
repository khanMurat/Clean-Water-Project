import 'package:final_project_ala/core/base/base_view_model.dart';
import 'package:final_project_ala/core/constants/enum/cache_keys.dart';
import 'package:final_project_ala/core/init/navigation/navigation_constant.dart';
import 'package:flutter/material.dart';

class SplashViewModel extends BaseViewModel {
  SplashViewModel._();
  static final SplashViewModel _instance = SplashViewModel._();
  static SplashViewModel get instance => _instance;

  @override
  void init() async {
    await changeOpacity();
  }

  @override
  void setContext(BuildContext context) => this.context = context;

  double opacityLevel = 0;
  final int _durationTime = 3;

  Future<void> changeOpacity() async {
    await Duration(seconds: _durationTime);
    opacityLevel = 1;
    notifyListeners();
  }

  void afterSplash() {
    final rememberMe = cacheManager.getBool(CacheKeys.rememberMe);

    if (rememberMe == true) {
      navigationService.navigateToPageRemoveUntil(NavigationConstant.home);
    } else {
      navigationService.navigateToPageRemoveUntil(NavigationConstant.welcome);
    }
    notifyListeners();
  }
}
