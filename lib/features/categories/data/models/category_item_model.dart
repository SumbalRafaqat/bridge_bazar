import 'package:flutter/material.dart';

/// CategoryItemModel: "Explore Categories" screen ke bento-grid card
/// ka data (Figma: 7 categories — Fruits & Veg, Dairy & Eggs, Meat &
/// Seafood, Bakery, Snacks, Beverages, Household).
///
/// Home screen ke chhote icon-grid ke liye "CategoryModel" (features/
/// home) pehle se hai — yeh ALAG model hai kyunke yahan bade IMAGE
/// cards chahiye (background photo + gradient + icon), sirf chhota
/// icon nahi. Isi liye do alag models banaye.
class CategoryItemModel {
  final String id;
  final String name;
  final IconData icon;
  final Color accentColor; // placeholder image background tint

  const CategoryItemModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.accentColor,
  });
}
