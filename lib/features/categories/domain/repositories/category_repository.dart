import '../../data/models/category_item_model.dart';

abstract class CategoryRepository {
  Future<List<CategoryItemModel>> getCategories();
}
