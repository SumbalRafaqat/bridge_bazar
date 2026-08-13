import '../../data/models/category_model.dart';
import '../../data/models/deal_model.dart';
import '../../data/models/promo_banner_model.dart';
import '../../data/models/store_preview_model.dart';

/// HomeRepository: contract — Home screen ko chahiye 4 cheezein:
/// banners, deals, categories, nearby stores.
abstract class HomeRepository {
  Future<List<PromoBannerModel>> getPromoBanners();
  Future<List<DealModel>> getDeals();
  Future<List<CategoryModel>> getCategories();
  Future<List<StorePreviewModel>> getNearbyStores();
}
