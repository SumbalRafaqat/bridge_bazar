import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/user_role.dart';
import '../widgets/role_selection_card.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

/// WelcomeScreen: Figma "Welcome to BazaarBridge" frame (1:68) se EXACT
/// match. Yeh app ka onboarding/role-selection screen hai — naye users
/// yahan se "Shopper" ya "Seller" role choose karte hain, phir Signup
/// screen par jaate hain. Purane users "Log in" link se Login screen
/// par ja sakte hain.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _goToSignup(BuildContext context, UserRole role) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SignupScreen(selectedRole: role)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceContainerLowest, // white
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ===== Hero Section with Illustration (1:110) =====
            // Figma mein asal illustration (bazaar/market image) hai.
            // Woh Figma ke temporary CDN se aata hai (7 din baad expire
            // ho jata), is liye yahan ek decorative placeholder banaya
            // hai. Jab real illustration asset mile, isay
            // Image.asset('assets/welcome_illustration.png') se
            // replace kar dena.
            Container(
              height: 320,
              margin: const EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow, // #EFF4FF
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2, offset: const Offset(0, 1)),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.lg),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                    ),
                    child: const Center(
                      child: Icon(Icons.storefront_rounded, size: 96, color: AppColors.primary),
                    ),
                  ),
                ),
              ),
            ),

            // ===== Branding Section (1:70) =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.md),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_bag, color: AppColors.primary, size: 30),
                      const SizedBox(width: AppDimensions.xs),
                      Text(
                        'BazaarBridge',
                        style: AppTextStyles.displayLg.copyWith(color: AppColors.onSurface),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.sm), // 12px
                  Text(
                    'Connecting you to the heart of your local market.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyLg.copyWith(color: AppColors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.xl), // ~32-40px before cards

            // ===== Role Selection Cards (1:80) =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.md),
              child: Column(
                children: [
                  RoleSelectionCard(
                    icon: Icons.shopping_cart_outlined,
                    iconBackgroundColor: AppColors.primaryContainer.withOpacity(0.2),
                    iconColor: AppColors.primary,
                    title: 'Join as a Shopper',
                    description: 'Browse fresh groceries and household items from local vendors.',
                    onTap: () => _goToSignup(context, UserRole.shopper),
                  ),
                  const SizedBox(height: AppDimensions.md), // 16px gap (Figma)
                  RoleSelectionCard(
                    icon: Icons.storefront_outlined,
                    iconBackgroundColor: AppColors.secondaryContainer.withOpacity(0.2),
                    iconColor: AppColors.secondary,
                    title: 'Join as a Seller',
                    description: 'Set up your digital shop and reach more customers in your area.',
                    onTap: () => _goToSignup(context, UserRole.seller),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.xl),

            // ===== Footer Link (1:105) =====
            Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.xl),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                    children: [
                      const TextSpan(text: 'Already have an account? '),
                      TextSpan(
                        text: 'Log in',
                        style: AppTextStyles.labelLg.copyWith(color: AppColors.primaryContainer),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const LoginScreen()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
