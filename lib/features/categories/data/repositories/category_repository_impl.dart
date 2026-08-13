import '../../domain/repositories/category_repository.dart';
import '../datasources/category_remote_datasource.dart';
import '../models/category_item_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CategoryItemModel>> getCategories() => remoteDataSource.getCategories();
}
