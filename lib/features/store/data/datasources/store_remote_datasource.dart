import '../../domain/entities/product_entity.dart';
import '../models/product_model.dart';

/// StoreRemoteDataSource: "GET /stores/{id}/products" yahan aayegi.
/// Abhi mock — Figma "Green Valley Store" ke exact 4 products.
class StoreRemoteDataSource {
  Future<List<ProductModel>> getStoreProducts(String storeId) async {
    // TODO: Replace with real API call using storeId.
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      ProductModel(id: 'p1', name: 'Fresh Tomatoes (1kg)', price: 120, badge: ProductBadge.fastDelivery),
      ProductModel(id: 'p2', name: 'Farm Milk (1L)', price: 180, badge: ProductBadge.inStock),
      ProductModel(id: 'p3', name: 'Artisan Bread Loaf', price: 150),
      ProductModel(id: 'p4', name: 'Organic Farm Eggs (12 pcs)', price: 320),
    ];
  }
}
