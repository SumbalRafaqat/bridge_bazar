import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';

/// SplashScreen: yeh sirf UI dikhati hai — koi logic (timer, navigation
/// decision) yahan nahi hai. Wo sab SplashBloc mein hai.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider: SplashBloc ko is widget subtree ke liye "create" karta
    // hai, taake neeche BlocBuilder/BlocListener isay access kar sakein.
    return BlocProvider(
      create: (_) => SplashBloc()..add(const SplashStarted()),
      // ..add() ka matlab: bloc bante hi turant SplashStarted event bhej do,
      // taake 2-second timer shuru ho jaye.
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    // BlocListener: yeh STATE ko "sunta" hai (UI nahi banata) — jab
    // SplashNavigateToLogin state aaye to Navigator se agli screen kholta hai.
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigateToLogin) {
          // TODO: jab Login screen ban jaye to yahan iska route lagayein.
          // Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Container(
            width: AppDimensions.logoContainerSize,
            height: AppDimensions.logoContainerSize,
            decoration: BoxDecoration(
              color: AppColors.onPrimary, // white
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              border: Border.all(color: AppColors.surfaceContainerLow),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 30,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            // TODO: Figma frame mein logo abhi khaali hai (koi image asset
            // nahi mila). Jab BazaarBridge ka actual logo image milay,
            // is Icon ko Image.asset('assets/logo.png') se replace kar dein.
            child: const Icon(
              Icons.storefront_rounded,
              color: AppColors.primary,
              size: 56,
            ),
          ),
        ),
      ),
    );
  }
}
