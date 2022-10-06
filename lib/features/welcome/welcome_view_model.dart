import 'package:final_project_ala/core/base/base_view_model.dart';
import 'package:final_project_ala/core/init/navigation/navigation_constant.dart';
import 'package:flutter/material.dart';

class WelcomeViewModel extends BaseViewModel {
  @override
  void init() {}

  @override
  void setContext(BuildContext context) => this.context = context;

  void navigateToLogin() {
    navigationService.navigateToPage(NavigationConstant.login);
  }

  void navigateToRegister() {
    navigationService.navigateToPage(NavigationConstant.register);
  }
}
