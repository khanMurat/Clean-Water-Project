import 'package:final_project_ala/core/base/base_view_model.dart';
import 'package:final_project_ala/core/init/navigation/navigation_constant.dart';
import 'package:final_project_ala/models/image/image_model.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends BaseViewModel {
  @override
  void init() {}

  @override
  void setContext(BuildContext context) => this.context = context;

  List<ImageModel> imagesWhyWater() {
    return [
      ImageModel('assets/images/pageView1.png'),
      ImageModel('assets/images/pageView2.png'),
      ImageModel('assets/images/pageView3.png'),
    ];
  }

  List<ImageModel> imagesInformation() {
    return [
      ImageModel('assets/images/home1.png'),
      ImageModel('assets/images/home2.png'),
      ImageModel('assets/images/home3.png'),
      ImageModel('assets/images/home4.png'),
      ImageModel('assets/images/home5.png'),
      ImageModel('assets/images/home6.png'),
    ];
  }

  void navigateToProject() {
    navigationService.navigateToPageRemoveUntil(NavigationConstant.project);
  }
}
