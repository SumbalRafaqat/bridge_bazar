/// AppDimensions: design.md ke "spacing" aur "rounded" section se liye gaye hain.
/// Jab bhi kisi widget mein padding/margin/radius dena ho, hardcode number
/// (jaise 16.0) likhne ke bajaye AppDimensions.xxx use karein.
class AppDimensions {
  AppDimensions._();

  // ===== Spacing (4px multiples) =====
  static const double base = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double gutter = 16;
  static const double marginMobile = 16;

  // ===== Rounded corners =====
  static const double radiusSm = 4;
  static const double radiusDefault = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
  static const double radiusFull = 9999;

  // ===== Common component sizes =====
  static const double buttonHeight = 48;
  static const double logoContainerSize = 128; // Splash screen logo box
}
