import 'package:flutter/material.dart';

/// CartItemModel: cart mein ek product ka record.
///
/// variant/badgeLabel OPTIONAL hain kyunke Store Products screen se
/// jab product add hota hai, humein sirf naam+price pata hota hai
/// (abhi mock data itna hi deta hai). Jab Cart screen apna design
/// dekha (Figma), pata chala ke cart items ke paas extra info bhi
/// hoti hai (weight/variant text, promotional badge jaisa "Fresh
/// Arrival"/"Best Seller") — is liye yeh fields ADD kiye, lekin
/// nullable rakha taake purana code (Store screen) tootay nahi.
class CartItemModel {
  final String productId;
  final String name;
  final int price;
  final int quantity;
  final String? variant;       // e.g. "1 kg", "Large Loaf"
  final String? badgeLabel;    // e.g. "Fresh Arrival", "Best Seller"
  final Color? badgeColor;
  final Color? badgeTextColor;

  const CartItemModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    this.variant,
    this.badgeLabel,
    this.badgeColor,
    this.badgeTextColor,
  });

  int get totalPrice => price * quantity;

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      productId: productId,
      name: name,
      price: price,
      quantity: quantity ?? this.quantity,
      variant: variant,
      badgeLabel: badgeLabel,
      badgeColor: badgeColor,
      badgeTextColor: badgeTextColor,
    );
  }
}
