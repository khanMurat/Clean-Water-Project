import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ala/models/payment/payment_info_model.dart';

class PaymentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> savePaymentInfo(PaymentInfoModel model) async {
    final paymentInfoMap = model.toMap();

    await _firestore
        .collection(model.uid)
        .doc(model.projectName)
        .set(paymentInfoMap);
  }
}
