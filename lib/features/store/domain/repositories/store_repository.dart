import '../entities/product_entity.dart';

abstract class StoreRepository {
  Future<List<ProductEntity>> getStoreProducts(String storeId);
}
