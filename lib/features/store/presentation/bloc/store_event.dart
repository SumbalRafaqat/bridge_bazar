import 'package:equatable/equatable.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();
  @override
  List<Object?> get props => [];
}

class StoreProductsRequested extends StoreEvent {
  final String storeId;
  const StoreProductsRequested(this.storeId);
  @override
  List<Object?> get props => [storeId];
}
