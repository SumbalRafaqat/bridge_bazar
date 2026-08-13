import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection_container.dart';
import 'core/theme/app_theme.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
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
    // MultiBlocProvider: yahan jo Blocs dete hain, woh POORI APP mein
    // kahin se bhi (context.read<CartBloc>()) available hote hain.
    // CartBloc isi liye yahan hai — Auth/Home/Splash ke Blocs alag hain
    // kyunke woh sirf apni screen tak seemit hain, lekin Cart ko
    // Store, Cart, Checkout — sab screens ko share karna hai.
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CartBloc()),
      ],
      child: MaterialApp(
        title: 'BazaarBridge',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
