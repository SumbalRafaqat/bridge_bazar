import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';
import '../models/category_model.dart';
import '../models/deal_model.dart';
import '../models/promo_banner_model.dart';
import '../models/store_preview_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PromoBannerModel>> getPromoBanners() => remoteDataSource.getPromoBanners();

  @override
  Future<List<DealModel>> getDeals() => remoteDataSource.getDeals();

  @override
  Future<List<CategoryModel>> getCategories() => remoteDataSource.getCategories();

  @override
  Future<List<StorePreviewModel>> getNearbyStores() => remoteDataSource.getNearbyStores();
}
