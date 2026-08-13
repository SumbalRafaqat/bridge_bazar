import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/store_repository.dart';
import '../datasources/store_remote_datasource.dart';

class StoreRepositoryImpl implements StoreRepository {
  final StoreRemoteDataSource remoteDataSource;
  StoreRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProductEntity>> getStoreProducts(String storeId) => remoteDataSource.getStoreProducts(storeId);
}
