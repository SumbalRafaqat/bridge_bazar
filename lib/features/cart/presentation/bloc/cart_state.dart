import 'package:equatable/equatable.dart';
import '../../data/models/cart_item_model.dart';

/// CartState: sirf EK state class hai (Loading/Error ki zaroorat nahi
/// kyunke cart abhi in-memory hai, koi API delay nahi). Bas current
/// items ki list rakhta hai.
class CartState extends Equatable {
  final List<CartItemModel> items;

  const CartState({this.items = const []});

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
  int get totalPrice => items.fold(0, (sum, item) => sum + item.totalPrice);

  /// Kisi product ki abhi cart mein kitni quantity hai — UI (quantity
  /// selector dikhana ya "+" button) isi se decide hoti hai.
  int quantityOf(String productId) {
    final match = items.where((i) => i.productId == productId);
    return match.isEmpty ? 0 : match.first.quantity;
  }

  @override
  List<Object?> get props => [items];
}
