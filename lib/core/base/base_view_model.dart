import 'package:final_project_ala/core/init/cache/cache_manager.dart';
import 'package:final_project_ala/core/init/navigation/navigation_service.dart';
import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier {
  BuildContext? context;

  NavigationService navigationService = NavigationService.instance;
  CacheManager cacheManager = CacheManager.instance;

  void setContext(BuildContext context);
  void init();
}
