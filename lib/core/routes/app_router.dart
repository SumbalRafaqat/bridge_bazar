import 'package:flutter/material.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/categories/presentation/screens/categories_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';

/// AppRouter: Bottom Nav Bar (jo Home/Categories/Store/Cart — sab
/// screens par dikhta hai) ka navigation logic EK JAGAH rakha hai —
/// taake har screen mein alag-alag switch-case na likhna pade.
///
/// pushReplacement use kiya hai (push nahi) — kyunke bottom-nav tabs
/// "switch karna" hai, "stack mein aur ek screen daalna" nahi. Warna
/// Home→Categories→Cart→Home baar baar tap karne se stack mein screens
/// jama hoti jaatin (back button se ajeeb behavior hota).
class AppRouter {
  AppRouter._();

  static void navigateToTab(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
        break;
      case 1:
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const CategoriesScreen()));
        break;
      case 2:
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const CartScreen()));
        break;
      case 3:
        // TODO: Profile screen abhi nahi bani — jab banegi, yahan navigate karna.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile screen abhi ban rahi hai — jald aayegi!')),
        );
        break;
    }
  }
}
