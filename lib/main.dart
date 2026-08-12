import 'package:flutter/material.dart';

import 'core/di/injection_container.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/presentation/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies(); // get_it setup

  runApp(const BazaarBridgeApp());
}

class BazaarBridgeApp extends StatelessWidget {
  const BazaarBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BazaarBridge',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
