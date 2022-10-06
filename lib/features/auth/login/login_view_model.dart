import 'package:final_project_ala/core/base/base_view_model.dart';
import 'package:final_project_ala/core/constants/enum/cache_keys.dart';
import 'package:final_project_ala/core/constants/text_constants.dart';
import 'package:final_project_ala/core/init/cache/cache_manager.dart';
import 'package:final_project_ala/core/init/navigation/navigation_constant.dart';
import 'package:final_project_ala/features/auth/login/login_service.dart';
import 'package:final_project_ala/ui/components/snackbar/custom_snackBar.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseViewModel {
  @override
  void init() {}

  @override
  void setContext(BuildContext context) => this.context = context;

  final LoginService _service = LoginService();

  bool? remember = false;

  bool isVisible = false;

  void changedVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void navigateToRegister() {
    navigationService.navigateToPageRemoveUntil(NavigationConstant.register);
  }

  void signIn(String email, String password) async {
    final either = await _service.userLogin(email, password);

    either.fold(
      (user) async {
        navigationService.navigateToPageRemoveUntil(NavigationConstant.home);
        await CacheManager.instance
            .saveString(CacheKeys.name, user!.email.toString());
      },
      (e) => CustomSnackBar(context!)
          .showSnackBar(AuthConstants.loginErrorText, Colors.red),
    );
  }

  void rememberMe() {
    remember = !remember!;

    cacheManager.saveBool(CacheKeys.rememberMe, remember ?? false);
    notifyListeners();
  }
}
