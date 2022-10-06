import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:final_project_ala/core/init/navigation/navigation_constant.dart';
import 'package:final_project_ala/core/init/navigation/navigation_service.dart';
import 'package:flutter/material.dart';

class CustomDialog extends AwesomeDialog {
  CustomDialog({required super.context});

  void showSuccessPaymentDialog(
    BuildContext context,
  ) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Success',
      desc: 'Thank you for your donation',
      btnOk: TextButton(
        onPressed: () {
          NavigationService.instance
              .navigateToPageRemoveUntil(NavigationConstant.project);
        },
        child: const Text(
          'OK',
          textAlign: TextAlign.center,
        ),
      ),
    ).show();
  }

  void showErrorPaymentDialog(
    BuildContext context,
  ) {
    AwesomeDialog(
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'Payment not received',
        btnOk: TextButton(
          onPressed: () {
            NavigationService.instance.navigateToPop();
          },
          child: const Text('OK'),
        )).show();
  }
}
