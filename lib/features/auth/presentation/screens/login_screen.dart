import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/social_auth_buttons.dart';
import 'signup_screen.dart';

/// LoginScreen: Figma "Login to BazaarBridge" frame se EXACT match.
/// BlocProvider yahan bloc create karta hai — is se AuthBloc sirf
/// tab tak zinda rehta hai jab tak yeh screen open hai (memory-efficient).
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        // TODO: jab get_it (sl) mein AuthRepository register ho jaye,
        // yahan sl<LoginUseCase>() use karna behtar practice hai.
        loginUseCase: LoginUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
        signupUseCase: SignupUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
      ),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginRequested(
          emailOrPhone: _emailOrPhoneController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface, // #F8F9FF (Figma)
      // ===== Header - TopAppBar (Figma: 1:6) =====
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => Navigator.maybePop(context),
        ),
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          'BazaarBridge',
          style: AppTextStyles.displayLg.copyWith(color: AppColors.primary),
        ),
      ),
      // BlocListener: sirf "side effects" (navigate / snackbar) ke liye —
      // UI khud BlocBuilder se render hoti hai.
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            // TODO: Home screen banne ke baad yahan navigate karna:
            // Navigator.pushReplacementNamed(context, AppRoutes.home);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.md, // 16px
            vertical: 32,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448), // Figma max-w
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ===== Header Text (1:16) =====
                    Text(
                      'Welcome Back',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headlineLg.copyWith(color: AppColors.onSurface),
                    ),
                    const SizedBox(height: AppDimensions.sm), // 12px
                    Text(
                      'Log in to continue your journey with BazaarBridge.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyLg.copyWith(color: AppColors.onSurfaceVariant),
                    ),
                    const SizedBox(height: AppDimensions.lg), // 24px

                    // ===== Login Form Card (1:21) =====
                    Container(
                      padding: const EdgeInsets.fromLTRB(25, 33, 25, 25),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLowest, // white
                        borderRadius: BorderRadius.circular(AppDimensions.radiusMd), // 12px
                        border: Border.all(color: AppColors.surfaceContainerHighest),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Email/Phone field
                          AppTextField(
                            label: 'Email/Phone Number',
                            hint: 'Enter your email or phone',
                            controller: _emailOrPhoneController,
                            keyboardType: TextInputType.emailAddress,
                            fillColor: AppColors.surface,
                            borderColor: AppColors.outlineVariant,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email ya phone number likhein';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: AppDimensions.sm), // 12px

                          // Password field
                          AppTextField(
                            label: 'Password',
                            hint: 'Enter your password',
                            controller: _passwordController,
                            obscureText: true,
                            fillColor: AppColors.surface,
                            borderColor: AppColors.outlineVariant,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password likhna zaroori hai';
                              }
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // TODO: Forgot password screen/flow
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 32),
                              ),
                              child: Text(
                                'Forgot password?',
                                style: AppTextStyles.labelSm.copyWith(color: AppColors.primary),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppDimensions.xs), // 8px

                          // ===== Log In button =====
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              return SizedBox(
                                height: AppDimensions.buttonHeight,
                                child: ElevatedButton(
                                  onPressed: state is AuthLoading ? null : _onLoginPressed,
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
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                      : Text(
                                    'Log In',
                                    style: AppTextStyles.labelLg.copyWith(color: AppColors.onPrimary),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimensions.lg), // 24px

                    // ===== OR CONTINUE WITH divider (1:45) =====
                    Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.outlineVariant.withOpacity(0.5))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.md),
                          child: Text(
                            'OR CONTINUE WITH',
                            style: AppTextStyles.labelSm.copyWith(
                              color: AppColors.onSurfaceVariant,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: AppColors.outlineVariant.withOpacity(0.5))),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.md), // 16px

                    // ===== Social buttons (1:50) — pill shape on Login =====
                    const SocialAuthButtons(borderRadius: AppDimensions.radiusFull),
                    const SizedBox(height: AppDimensions.xs),

                    // ===== Footer link (1:66) =====
                    Padding(
                      padding: const EdgeInsets.only(top: AppDimensions.xs),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                            children: [
                              const TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: 'Sign Up',
                                style: AppTextStyles.labelLg.copyWith(color: AppColors.primary),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (_) => const SignupScreen()),
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
            ),
          ),
        ),
      ),
    );
  }
}