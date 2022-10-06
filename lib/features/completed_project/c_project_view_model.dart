import 'package:final_project_ala/core/base/base_view_model.dart';
import 'package:final_project_ala/models/completed-project/c_project_model.dart';
import 'package:final_project_ala/features/completed_project/c_project_service.dart';
import 'package:flutter/material.dart';

class CProjectViewModel extends BaseViewModel {
  CProjectViewModel._init();
  static final CProjectViewModel _instance = CProjectViewModel._init();
  static CProjectViewModel get instance => _instance;

  @override
  void init() {}

  @override
  void setContext(BuildContext context) {}

  List<CProjectInfo> cProjectList = [];

  bool loading = false;

  Future<void> getCProjectList() async {
    isTrue();
    try {
      cProjectList = await CProjectModelList.instance.getCProjectInfo();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
    isFalse();
  }

  void isTrue() {
    loading = true;
    notifyListeners();
  }

  void isFalse() {
    loading = false;
    notifyListeners();
  }
}
