import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../features/home/presentation/screens/home_screen.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../../domain/entities/user_role.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/social_auth_buttons.dart';

/// SignupScreen: Figma "Sign Up for BazaarBridge" frame se EXACT match.
/// Login screen se subtle differences hain (jaan-boojh kar Figma ke
/// mutabiq): input fields ka bg #EFF4FF (surfaceContainerLow) hai,
/// border #6C7A71 (outline, gehra) hai — Login mein yeh halka tha.
/// Social buttons yahan "box" (radius 8) hain, Login mein "pill" thay.
///
/// selectedRole: Welcome screen se aata hai (Shopper/Seller). Abhi UI
/// mein iska koi visual asar nahi (Figma design mein role field nahi
/// dikhaya gaya), lekin future mein backend ko "role" bhejne ke kaam
/// aayega — is liye field yahan store kar rahe hain.
class SignupScreen extends StatelessWidget {
  final UserRole? selectedRole;

  const SignupScreen({super.key, this.selectedRole});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        loginUseCase: LoginUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
        signupUseCase: SignupUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
      ),
      child: _SignupView(selectedRole: selectedRole),
    );
  }
}

class _SignupView extends StatefulWidget {
  final UserRole? selectedRole;

  const _SignupView({this.selectedRole});

  @override
  State<_SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<_SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onCreateAccountPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            SignupRequested(
              fullName: _fullNameController.text.trim(),
              email: _emailController.text.trim(),
              phone: _phoneController.text.trim(),
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      // ===== Header - TopAppBar (1:115) =====
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => Navigator.maybePop(context),
        ),
        centerTitle: true,
        title: Text(
          'BazaarBridge',
          style: AppTextStyles.displayLg.copyWith(color: AppColors.primary),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.md, vertical: 27),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                  border: Border.all(color: AppColors.surfaceContainerHighest),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ===== Header text (1:125) =====
                      Text(
                        'Create Account',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headlineLg.copyWith(color: AppColors.onSurface),
                      ),
                      const SizedBox(height: AppDimensions.base * 2), // 8px
                      Text(
                        'Join our community of shoppers and sellers.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                      ),
                      const SizedBox(height: AppDimensions.md), // ~16px before form

                      // ===== Full Name (1:130) =====
                      AppTextField(
                        label: 'Full Name',
                        hint: 'Enter your full name',
                        controller: _fullNameController,
                        prefixIcon: const Icon(Icons.person_outline, size: 16, color: AppColors.onSurfaceVariant),
                        fillColor: AppColors.surfaceContainerLow, // #EFF4FF
                        borderColor: AppColors.outline, // #6C7A71
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
                      ),
                      const SizedBox(height: AppDimensions.md),

                      // ===== Email (1:140) =====
                      AppTextField(
                        label: 'Email',
                        hint: 'Enter your email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.mail_outline, size: 16, color: AppColors.onSurfaceVariant),
                        fillColor: AppColors.surfaceContainerLow,
                        borderColor: AppColors.outline,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Please enter your email';
                          if (!v.contains('@')) return 'Please enter a valid email';
                          return null;
                        },
                      ),
                      const SizedBox(height: AppDimensions.md),

                      // ===== Phone (1:150) =====
                      AppTextField(
                        label: 'Phone Number',
                        hint: 'Enter your phone number',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        prefixIcon: const Icon(Icons.call_outlined, size: 15, color: AppColors.onSurfaceVariant),
                        fillColor: AppColors.surfaceContainerLow,
                        borderColor: AppColors.outline,
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your phone number' : null,
                      ),
                      const SizedBox(height: AppDimensions.md),

                      // ===== Password (1:160) =====
                      AppTextField(
                        label: 'Password',
                        hint: 'Create a password',
                        controller: _passwordController,
                        obscureText: true,
                        prefixIcon: const Icon(Icons.lock_outline, size: 14, color: AppColors.onSurfaceVariant),
                        fillColor: AppColors.surfaceContainerLow,
                        borderColor: AppColors.outline,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Please create a password';
                          if (v.length < 6) return 'Password must be at least 6 characters';
                          return null;
                        },
                      ),
                      const SizedBox(height: AppDimensions.lg), // 24px before button (~16 in figma, rounded)

                      // ===== Create Account button (1:173) =====
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return SizedBox(
                            height: AppDimensions.buttonHeight,
                            child: ElevatedButton(
                              onPressed: state is AuthLoading ? null : _onCreateAccountPressed,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                                ),
                              ),
                              child: state is AuthLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                    )
                                  : Text(
                                      'Create Account',
                                      style: AppTextStyles.labelLg.copyWith(color: AppColors.onPrimary),
                                    ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: AppDimensions.md),

                      // ===== "Or sign up with" divider (1:176) =====
                      Row(
                        children: [
                          Expanded(child: Divider(color: AppColors.outlineVariant)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.md),
                            child: Text(
                              'Or sign up with',
                              style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                            ),
                          ),
                          Expanded(child: Divider(color: AppColors.outlineVariant)),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.md),

                      // ===== Social buttons (1:181) — box shape (radius 8) on Signup =====
                      const SocialAuthButtons(borderRadius: AppDimensions.radiusDefault),
                      const SizedBox(height: AppDimensions.md),

                      // ===== Footer (1:195) =====
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                            children: [
                              const TextSpan(text: 'Already have an account? '),
                              TextSpan(
                                text: 'Log In',
                                style: AppTextStyles.labelLg.copyWith(color: AppColors.primary),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.maybePop(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.sm),

                      // ===== Legal text (1:198) =====
                      Text.rich(
                        TextSpan(
                          style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant),
                          children: const [
                            TextSpan(text: 'By signing up, you agree to our '),
                            TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(decoration: TextDecoration.underline),
                            ),
                            TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(decoration: TextDecoration.underline),
                            ),
                            TextSpan(text: '.'),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
