import 'package:final_project_ala/core/init/navigation/navigation_constant.dart';
import 'package:final_project_ala/features/auth/login/login_view.dart';
import 'package:final_project_ala/features/auth/register/register_view.dart';
import 'package:final_project_ala/features/completed_project/c_project_view.dart';
import 'package:final_project_ala/features/detail/detail_view.dart';
import 'package:final_project_ala/features/donation/donation_view.dart';
import 'package:final_project_ala/features/home/home_view.dart';
import 'package:final_project_ala/features/payment/payment_view.dart';
import 'package:final_project_ala/features/profile/profile_view.dart';
import 'package:final_project_ala/features/splash/splash_view.dart';
import 'package:final_project_ala/features/welcome/welcome_view.dart';
import 'package:final_project_ala/models/project/project_model.dart';
import 'package:flutter/material.dart';

import '../../../features/project/project_view.dart';

class NavigationManager {
  NavigationManager._init();
  static final NavigationManager _instance = NavigationManager._init();
  static NavigationManager get instance => _instance;

  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationConstant.splash:
        return pageRoute(NavigationConstant.splash, const SplashView());
      case NavigationConstant.welcome:
        return pageRoute(NavigationConstant.welcome, WelcomeView());
      case NavigationConstant.login:
        return pageRoute(NavigationConstant.login, const LoginView());
      case NavigationConstant.register:
        return pageRoute(NavigationConstant.register, const RegisterView());
      case NavigationConstant.home:
        return pageRoute(NavigationConstant.home, const HomeView());
      case NavigationConstant.project:
        return pageRoute(NavigationConstant.project, const ProjectView());
      case NavigationConstant.completedProject:
        return pageRoute(
            NavigationConstant.completedProject, const CProjectView());
      case NavigationConstant.profile:
        return pageRoute(NavigationConstant.profile, const ProfileView());
      case NavigationConstant.donation:
        return pageRoute(NavigationConstant.donation, const DonationView());
      case NavigationConstant.payment:
        return pageRoute(
            NavigationConstant.payment,
            PaymentView(
              projectModel: settings.arguments as ProjectInfo,
            ));
      case NavigationConstant.detail:
        return pageRoute(
            NavigationConstant.detail,
            DetailView(
              projectModel: settings.arguments as ProjectInfo,
            ));
    }
    return null;
  }

  MaterialPageRoute pageRoute(String routeName, Widget view, {Object? data}) {
    return MaterialPageRoute(
      builder: (context) => view,
      settings: RouteSettings(
        name: routeName,
        arguments: data,
      ),
    );
  }
}
