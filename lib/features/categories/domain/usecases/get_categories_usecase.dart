import '../../data/models/category_item_model.dart';
import '../repositories/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository repository;
  GetCategoriesUseCase(this.repository);

  Future<List<CategoryItemModel>> call() => repository.getCategories();
}
