import 'package:final_project_ala/core/base/base_view_model.dart';
import 'package:final_project_ala/core/constants/enum/cache_keys.dart';
import 'package:final_project_ala/core/init/cache/cache_manager.dart';
import 'package:final_project_ala/core/init/navigation/navigation_constant.dart';
import 'package:final_project_ala/features/auth/register/register_service.dart';
import 'package:final_project_ala/ui/components/snackbar/custom_snackBar.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends BaseViewModel {
  @override
  void init() {}

  @override
  void setContext(BuildContext context) => this.context = context;

  final RegisterService _service = RegisterService();

  bool isLoading = false;

  bool isVisible = false;

  void changedVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void navigateToLogin() {
    navigationService.navigateToPageRemoveUntil(NavigationConstant.login);
  }

  void register(String name, String email, String password) async {
    final either = await _service.registerUser(email, password);

    either.fold((user) async {
      await CacheManager.instance.saveString(CacheKeys.userUID, user!.uid);

      await CacheManager.instance
          .saveString(CacheKeys.name, user.email.toString());
      navigationService.navigateToPageRemoveUntil(NavigationConstant.home);
    }, (e) {
      CustomSnackBar(context!).showSnackBar(e.message ?? '', Colors.red);
    });
  }
}
