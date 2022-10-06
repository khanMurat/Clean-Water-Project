import 'package:final_project_ala/core/base/base_view_model.dart';
import 'package:final_project_ala/features/payment/payment_service.dart';
import 'package:final_project_ala/models/payment/payment_info_model.dart';
import 'package:flutter/material.dart';

import '../../ui/components/custom-dialog/awesome_dialog.dart';

class PaymentViewModel extends BaseViewModel {
  @override
  void init() {}

  @override
  void setContext(BuildContext context) => this.context = context;

  final PaymentService _service = PaymentService();

  Future<void> savePayment(String uid, String donationAmount,
      String projectName, String image) async {
    final paymentInfo =
        PaymentInfoModel(uid, donationAmount, projectName, image);
    await _service.savePaymentInfo(paymentInfo);
  }

  void showSuccessDialog(BuildContext context) {
    CustomDialog(context: context).showSuccessPaymentDialog(context);
  }

  void showErrorDialog(BuildContext context) {
    CustomDialog(context: context).showErrorPaymentDialog(context);
  }
}
