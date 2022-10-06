import 'package:final_project_ala/core/base/base_view_model.dart';
import 'package:final_project_ala/models/project/project_model.dart';
import 'package:final_project_ala/features/project/project_service.dart';
import 'package:flutter/material.dart';

class ProjectViewModel extends BaseViewModel {
  @override
  void init() {}

  @override
  void setContext(BuildContext context) => this.context = context;

  ProjectViewModel._init();
  static final ProjectViewModel _instance = ProjectViewModel._init();
  static ProjectViewModel get instance => _instance;

  List<ProjectInfo> projectList = [];

  bool loading = false;

  Future<void> getProjectList() async {
    isLoadingTrue();
    try {
      projectList = await ProjectModelList.instance.getProjectInfo();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
    isLoadingFalse();
  }

  void isLoadingTrue() {
    loading = true;
    notifyListeners();
  }

  void isLoadingFalse() {
    loading = false;
    notifyListeners();
  }
}
