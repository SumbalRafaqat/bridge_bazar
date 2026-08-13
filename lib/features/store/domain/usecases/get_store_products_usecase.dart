import '../entities/product_entity.dart';
import '../repositories/store_repository.dart';

class GetStoreProductsUseCase {
  final StoreRepository repository;
  GetStoreProductsUseCase(this.repository);

  Future<List<ProductEntity>> call(String storeId) => repository.getStoreProducts(storeId);
}
