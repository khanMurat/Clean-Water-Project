import 'package:final_project_ala/core/base/base_view_model.dart';
import 'package:final_project_ala/core/init/navigation/navigation_constant.dart';
import 'package:final_project_ala/ui/components/drawer/nav_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends BaseViewModel {
  @override
  void init() {}

  @override
  void setContext(BuildContext context) => this.context = context;

  final String _logOutText = 'Are you sure to logout?';
  final String _confirmText = 'Do you confirm?';

  List<NavItem> getDrawerItem(BuildContext context) {
    return [
      NavItem('Wipe Cache', Icons.delete, () {
        cacheManager.clearAll;
        showDialog(
            context: context,
            builder: (context) {
              return _AlertDialog(
                text: _confirmText,
                onPressedNo: () => navigationService.navigateToPop(),
                onPressedYes: () {
                  cacheManager.clearAll();
                  navigationService.navigateToPop();
                },
              );
            });
      }),
      NavItem('Logout', Icons.logout, () {
        showDialog(
            context: context,
            builder: (context) {
              return _AlertDialog(
                text: _logOutText,
                onPressedYes: () {
                  navigationService
                      .navigateToPageRemoveUntil(NavigationConstant.welcome);
                  FirebaseAuth.instance.signOut();
                },
                onPressedNo: () => navigationService.navigateToPop(),
              );
            });
      }),
    ];
  }
}

class _AlertDialog extends StatelessWidget {
  const _AlertDialog({
    Key? key,
    required this.text,
    this.onPressedNo,
    this.onPressedYes,
  }) : super(key: key);

  final String text;
  final void Function()? onPressedNo;
  final void Function()? onPressedYes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(text),
      actions: [
        OutlinedButton(onPressed: onPressedNo, child: const Text('No')),
        OutlinedButton(onPressed: onPressedYes, child: const Text('Yes')),
      ],
    );
  }
}
