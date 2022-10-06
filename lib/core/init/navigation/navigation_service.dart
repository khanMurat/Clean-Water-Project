import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._init();

  static final NavigationService _instance = NavigationService._init();
  static NavigationService get instance => _instance;

  GlobalKey<NavigatorState> navigationKey = GlobalKey();

  get predicate => (Route<dynamic> route) => false;

  void navigateToPage(String path, {Object? data}) {
    navigationKey.currentState!.pushNamed(path, arguments: data);
  }

  void navigateToPageRemoveUntil(String path, {Object? data}) {
    navigationKey.currentState!.pushNamedAndRemoveUntil(
      path,
      predicate,
      arguments: data,
    );
  }

  void navigateToPop({Object? data}) {
    navigationKey.currentState!.pop(data);
  }
}
