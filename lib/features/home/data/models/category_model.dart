import 'package:flutter/material.dart';

/// CategoryModel: "Explore Categories" grid ka ek item
/// (Figma: Fruits & Veg, Dairy, Meat, Snacks).
class CategoryModel {
  final String id;
  final String name;
  final IconData icon;

  const CategoryModel({required this.id, required this.name, required this.icon});
}
