import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/cart_item_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

/// CartBloc: yeh Bloc APP-LEVEL hai — main.dart mein ek hi baar
/// bana kar poori app ke liye "globally available" kiya jayega
/// (MultiBlocProvider se), taake Store Products, Cart, Checkout —
/// sab screens isi EK cart ko share karein (har screen apna
/// ALAG bloc nahi banati, jaisa Auth/Home mein tha).
///
/// Abhi TODO: yeh sirf RAM (memory) mein cart rakhta hai — app band
/// hote hi khaali ho jayega. Jab Firestore lagayenge, yahan
/// save/load logic add hogi.
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartItemAdded>(_onItemAdded);
    on<CartItemQuantityChanged>(_onQuantityChanged);
    on<CartItemRemoved>(_onItemRemoved);
    on<CartCleared>((event, emit) => emit(const CartState()));
  }

  void _onItemAdded(CartItemAdded event, Emitter<CartState> emit) {
    final items = List<CartItemModel>.from(state.items);
    final index = items.indexWhere((i) => i.productId == event.productId);

    if (index == -1) {
      items.add(CartItemModel(
        productId: event.productId,
        name: event.name,
        price: event.price,
        quantity: 1,
        variant: event.variant,
        badgeLabel: event.badgeLabel,
        badgeColor: event.badgeColor,
        badgeTextColor: event.badgeTextColor,
      ));
    } else {
      items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
    }
    emit(CartState(items: items));
  }

  void _onQuantityChanged(CartItemQuantityChanged event, Emitter<CartState> emit) {
    final items = List<CartItemModel>.from(state.items);
    final index = items.indexWhere((i) => i.productId == event.productId);
    if (index == -1) return;

    if (event.quantity <= 0) {
      items.removeAt(index);
    } else {
      items[index] = items[index].copyWith(quantity: event.quantity);
    }
    emit(CartState(items: items));
  }

  void _onItemRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    final items = List<CartItemModel>.from(state.items)..removeWhere((i) => i.productId == event.productId);
    emit(CartState(items: items));
  }
}
