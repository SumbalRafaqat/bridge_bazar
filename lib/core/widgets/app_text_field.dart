import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../theme/app_text_styles.dart';

/// AppTextField: poore app mein reusable input field.
/// Figma design ke mutabiq: Label (semi-bold) upar, phir rounded
/// input box jisme optional icon (left) aur optional toggle button
/// (right — password ke liye "eye" icon) hota hai.
///
/// Kyunke Login screen aur Signup screen ke input boxes ka
/// background/border color Figma mein alag hai (Login = halka white-ish
/// #F8F9FF bg + #BBCABF border; Signup = #EFF4FF bg + #6C7A71 border),
/// isliye fillColor/borderColor ko PARAMETER banaya hai — hardcode
/// nahi kiya — taake Figma se exact match ho aur widget dono jagah
/// reuse ho sake.
class AppTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final bool obscureText;
  final Color fillColor;
  final Color borderColor;
  final Color hintColor;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.prefixIcon,
    this.obscureText = false,
    this.fillColor = AppColors.surface,
    this.borderColor = AppColors.outlineVariant,
    this.hintColor = AppColors.onSurfaceVariant,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  // Password field ke liye: abhi text dikh raha hai ya chhupa hua hai.
  late bool _obscured;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ===== Label (jaise "Email/Phone Number", "Password") =====
        Text(
          widget.label,
          style: AppTextStyles.labelLg.copyWith(color: AppColors.onSurface),
        ),
        const SizedBox(height: AppDimensions.base), // 4px gap (Figma)
        // ===== Input box =====
        TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText ? _obscured : false,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurface),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.bodyMd.copyWith(
              color: widget.hintColor.withOpacity(0.5),
            ),
            filled: true,
            fillColor: widget.fillColor,
            prefixIcon: widget.prefixIcon,
            prefixIconConstraints: const BoxConstraints(minWidth: 33, minHeight: 17),
            suffixIcon: widget.obscureText
                ? IconButton(
                    // Figma: "Button - Toggle password visibility"
                    icon: Icon(
                      _obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: 18,
                      color: AppColors.onSurfaceVariant,
                    ),
                    onPressed: () => setState(() => _obscured = !_obscured),
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.sm,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusDefault), // 8px
              borderSide: BorderSide(color: widget.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusDefault),
              borderSide: BorderSide(color: widget.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusDefault),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusDefault),
              borderSide: const BorderSide(color: AppColors.error),
            ),
          ),
        ),
      ],
    );
  }
}
