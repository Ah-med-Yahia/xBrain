import 'package:explaino/config/di/di.dart';
import 'package:explaino/core/routing/app_router.dart';
import 'package:explaino/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const ExplainoApp());
}

class ExplainoApp extends StatelessWidget {
  const ExplainoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
