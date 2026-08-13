import 'package:equatable/equatable.dart';
import '../../domain/entities/product_entity.dart';

abstract class StoreState extends Equatable {
  const StoreState();
  @override
  List<Object?> get props => [];
}

class StoreLoading extends StoreState {
  const StoreLoading();
}

class StoreLoaded extends StoreState {
  final List<ProductEntity> products;
  const StoreLoaded(this.products);
  @override
  List<Object?> get props => [products];
}

class StoreError extends StoreState {
  final String message;
  const StoreError(this.message);
  @override
  List<Object?> get props => [message];
}
