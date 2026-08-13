import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.price,
    super.badge,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      badge: ProductBadge.values.firstWhere(
        (b) => b.name == json['badge'],
        orElse: () => ProductBadge.none,
      ),
    );
  }
}
