import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

/// Product ko cart mein add karna (agar already hai to quantity +1).
/// variant/badge OPTIONAL — Store screen se add karte waqt inhe pass
/// nahi karte (default null), lekin Cart screen ka UI dono cases
/// (badge ho ya na ho) handle karta hai.
class CartItemAdded extends CartEvent {
  final String productId;
  final String name;
  final int price;
  final String? variant;
  final String? badgeLabel;
  final Color? badgeColor;
  final Color? badgeTextColor;

  const CartItemAdded({
    required this.productId,
    required this.name,
    required this.price,
    this.variant,
    this.badgeLabel,
    this.badgeColor,
    this.badgeTextColor,
  });

  @override
  List<Object?> get props => [productId, name, price, variant, badgeLabel];
}

/// Quantity ko seedha ek number set karna (+ / - buttons se).
class CartItemQuantityChanged extends CartEvent {
  final String productId;
  final int quantity; // 0 = item cart se hata do

  const CartItemQuantityChanged({required this.productId, required this.quantity});

  @override
  List<Object?> get props => [productId, quantity];
}

class CartItemRemoved extends CartEvent {
  final String productId;
  const CartItemRemoved(this.productId);

  @override
  List<Object?> get props => [productId];
}

/// Header ka trash/delete icon dabane par — poora cart khaali kar deta hai.
class CartCleared extends CartEvent {
  const CartCleared();
}
