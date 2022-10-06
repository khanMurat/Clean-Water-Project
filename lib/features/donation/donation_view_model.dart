import 'package:final_project_ala/core/base/base_view_model.dart';
import 'package:final_project_ala/features/donation/donation_service.dart';
import 'package:final_project_ala/models/donation/donation_model.dart';
import 'package:flutter/material.dart';

class DonationViewModel extends BaseViewModel {
  DonationViewModel._init();
  static final DonationViewModel _instance = DonationViewModel._init();
  static DonationViewModel get instance => _instance;

  @override
  void init() {}

  @override
  void setContext(BuildContext context) => this.context = context;

  List<DonationInfo> donationList = [];

  bool loading = false;

  Future<void> getDonateList() async {
    try {
      donationList = await DonationService.instance.getDonationInfo();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
