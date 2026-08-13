import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/deal_model.dart';
import '../models/promo_banner_model.dart';
import '../models/store_preview_model.dart';

/// HomeRemoteDataSource: yahan asal API call hogi ("GET /home-feed").
/// Abhi backend nahi hai, is liye MOCK data return kar rahe hain —
/// bilkul Figma design ke mutabiq (same names/prices) — taake UI
/// turant test ho sake.
class HomeRemoteDataSource {
  Future<List<PromoBannerModel>> getPromoBanners() async {
    // TODO: Replace with real API call.
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      PromoBannerModel(
        id: 'promo_1',
        badgeText: 'LIMITED TIME',
        titleLine1: 'Flat 20% Off on',
        titleLine2: 'Groceries',
      ),
    ];
  }

  Future<List<DealModel>> getDeals() async {
    // TODO: Replace with real API call.
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      DealModel(
        id: 'deal_1',
        name: 'Sindhri Mangoes (3kg)',
        price: 850,
        originalPrice: 1100,
        saveLabel: 'Save Rs. 250',
      ),
      DealModel(
        id: 'deal_2',
        name: 'Fresh Whole Chicken',
        price: 650,
        originalPrice: 800,
        saveLabel: 'Save Rs. 150',
      ),
    ];
  }

  Future<List<CategoryModel>> getCategories() async {
    // TODO: Replace with real API call.
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      CategoryModel(id: 'cat_1', name: 'Fruits & Veg', icon: Icons.eco_outlined),
      CategoryModel(id: 'cat_2', name: 'Dairy', icon: Icons.icecream_outlined),
      CategoryModel(id: 'cat_3', name: 'Meat', icon: Icons.set_meal_outlined),
      CategoryModel(id: 'cat_4', name: 'Snacks', icon: Icons.cookie_outlined),
    ];
  }

  Future<List<StorePreviewModel>> getNearbyStores() async {
    // TODO: Replace with real API call.
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      StorePreviewModel(
        id: 'store_1',
        name: 'FreshMart Superstore',
        rating: 4.8,
        reviewCount: 120,
        distanceKm: 1.2,
        etaMinutes: 20,
        isFastDelivery: true,
      ),
      StorePreviewModel(
        id: 'store_2',
        name: 'Green Valley Grocers',
        rating: 4.5,
        reviewCount: 85,
        distanceKm: 2.5,
        etaMinutes: 30,
        isFastDelivery: false,
      ),
    ];
  }
}
