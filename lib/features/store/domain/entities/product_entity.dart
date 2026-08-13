/// ProductBadge: product card ke upar dikhne wala chhota tag
/// (Figma: "Fast Delivery" = orange, "In Stock" = light box, none = kuch nahi).
enum ProductBadge { fastDelivery, inStock, none }

/// ProductEntity: pure business object — "Popular Items" grid ka
/// ek product.
class ProductEntity {
  final String id;
  final String name;
  final int price;
  final ProductBadge badge;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    this.badge = ProductBadge.none,
  });
}
