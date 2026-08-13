import 'package:flutter/material.dart';
import '../models/category_item_model.dart';

/// CategoryRemoteDataSource: asal API yahan aayegi ("GET /categories").
/// Abhi mock data hai — Home screen jaisa hi pattern (koi backend nahi
/// hai abhi), Figma ke 7 categories ke exact naam ke sath.
class CategoryRemoteDataSource {
  Future<List<CategoryItemModel>> getCategories() async {
    // TODO: Replace with real API call.
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      CategoryItemModel(id: 'c1', name: 'Fruits & Veg', icon: Icons.eco_outlined, accentColor: Color(0xFF4CAF50)),
      CategoryItemModel(id: 'c2', name: 'Dairy & Eggs', icon: Icons.icecream_outlined, accentColor: Color(0xFF64B5F6)),
      CategoryItemModel(id: 'c3', name: 'Meat & Seafood', icon: Icons.set_meal_outlined, accentColor: Color(0xFFE57373)),
      CategoryItemModel(id: 'c4', name: 'Bakery', icon: Icons.bakery_dining_outlined, accentColor: Color(0xFFFFB74D)),
      CategoryItemModel(id: 'c5', name: 'Snacks', icon: Icons.cookie_outlined, accentColor: Color(0xFFBA68C8)),
      CategoryItemModel(id: 'c6', name: 'Beverages', icon: Icons.local_drink_outlined, accentColor: Color(0xFF4DB6AC)),
      CategoryItemModel(id: 'c7', name: 'Household', icon: Icons.cleaning_services_outlined, accentColor: Color(0xFF90A4AE)),
    ];
  }
}
