import '../../data/models/category_model.dart';
import '../../data/models/deal_model.dart';
import '../../data/models/promo_banner_model.dart';
import '../../data/models/store_preview_model.dart';
import '../repositories/home_repository.dart';

/// HomeFeed: chaaron lists ko ek object mein bundle karta hai —
/// taake BLoC sirf EK state ke andar sab kuch rakh sake.
class HomeFeed {
  final List<PromoBannerModel> banners;
  final List<DealModel> deals;
  final List<CategoryModel> categories;
  final List<StorePreviewModel> stores;

  const HomeFeed({
    required this.banners,
    required this.deals,
    required this.categories,
    required this.stores,
  });
}

/// GetHomeFeedUseCase: Home screen khulte hi yeh 4 API calls
/// EK SATH (parallel) chalata hai — Future.wait se — taake screen
/// jaldi load ho (sequential 4 calls se zyada tez).
class GetHomeFeedUseCase {
  final HomeRepository repository;

  GetHomeFeedUseCase(this.repository);

  Future<HomeFeed> call() async {
    final results = await Future.wait([
      repository.getPromoBanners(),
      repository.getDeals(),
      repository.getCategories(),
      repository.getNearbyStores(),
    ]);

    return HomeFeed(
      banners: results[0] as List<PromoBannerModel>,
      deals: results[1] as List<DealModel>,
      categories: results[2] as List<CategoryModel>,
      stores: results[3] as List<StorePreviewModel>,
    );
  }
}
