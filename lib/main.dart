import 'package:final_project_ala/core/init/cache/cache_manager.dart';
import 'package:final_project_ala/core/init/navigation/navigation_manager.dart';
import 'package:final_project_ala/core/init/navigation/navigation_service.dart';
import 'package:final_project_ala/features/auth/login/login_view_model.dart';
import 'package:final_project_ala/features/auth/register/register_view_model.dart';
import 'package:final_project_ala/features/completed_project/c_project_view_model.dart';
import 'package:final_project_ala/features/donation/donation_view_model.dart';
import 'package:final_project_ala/features/project/project_view_model.dart';
import 'package:final_project_ala/features/splash/splash_view.dart';
import 'package:final_project_ala/features/splash/splash_view_model.dart';
import 'package:final_project_ala/ui/theme/custom_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheManager.preferencesInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashViewModel.instance),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => ProjectViewModel.instance),
        ChangeNotifierProvider(create: (_) => CProjectViewModel.instance),
        ChangeNotifierProvider(create: (_) => DonationViewModel.instance),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: NavigationManager.instance.generateRoute,
          navigatorKey: NavigationService.instance.navigationKey,
          theme: CustomTheme.instance.lightTheme,
          home: const SplashView(),
        );
      },
    );
  }
}
