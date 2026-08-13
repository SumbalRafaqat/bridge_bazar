import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/product_card.dart';
import '../../../../core/widgets/search_bar_widget.dart';
import '../../../categories/presentation/screens/categories_screen.dart';
import '../../../store/presentation/screens/store_products_screen.dart';
import '../../data/datasources/home_remote_datasource.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/usecases/get_home_feed_usecase.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/category_grid.dart';
import '../widgets/promo_banner_carousel.dart';
import '../widgets/store_card.dart';

/// HomeScreen: Figma "Customer Dashboard" (1:204) se EXACT match.
/// Sections (upar se neeche): TopAppBar (location+notif) → Search Bar
/// → Promo Banner → Deals of the Week (horizontal scroll) →
/// Explore Categories (row) → Stores Near You (horizontal scroll)
/// → Bottom Nav Bar.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        // TODO: get_it (sl) se inject karna behtar hoga jab DI poori setup ho.
        getHomeFeedUseCase: GetHomeFeedUseCase(HomeRepositoryImpl(HomeRemoteDataSource())),
      )..add(const HomeFeedRequested()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      // ===== Header - TopAppBar (1:206) =====
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: InkWell(
          onTap: () {
            // TODO: location picker bottom-sheet
          },
          borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.md),
            child: Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 20, color: AppColors.primary),
                const SizedBox(width: AppDimensions.base * 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Delivering to', style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant)),
                    Row(
                      children: [
                        Text(
                          'DHA Phase 6, Lahore',
                          style: AppTextStyles.bodyLg.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.primary),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded, color: AppColors.onSurface),
                onPressed: () {
                  // TODO: Notifications screen
                },
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryContainer,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surface),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: AppDimensions.xs),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }
          if (state is HomeError) {
            return Center(
              child: Text(state.message, style: AppTextStyles.bodyLg.copyWith(color: AppColors.error)),
            );
          }

          final feed = (state as HomeLoaded).feed;

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async => context.read<HomeBloc>().add(const HomeFeedRequested()),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.md, vertical: AppDimensions.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ===== Search Bar (1:222) =====
                  const SearchBarWidget(),
                  const SizedBox(height: AppDimensions.xl), // 32px gap between sections

                  // ===== Promo Banner (1:232) =====
                  PromoBannerCarousel(banners: feed.banners),
                  const SizedBox(height: AppDimensions.xl),

                  // ===== Deals of the Week (1:241) =====
                  _SectionHeader(title: 'Deals of the Week', onSeeAll: () {}),
                  const SizedBox(height: AppDimensions.sm),
                  SizedBox(
                    height: 274,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: feed.deals.length,
                      separatorBuilder: (_, __) => const SizedBox(width: AppDimensions.md),
                      itemBuilder: (context, i) {
                        final deal = feed.deals[i];
                        return ProductCard(
                          name: deal.name,
                          price: deal.price,
                          originalPrice: deal.originalPrice,
                          badgeLabel: deal.saveLabel,
                          onAddPressed: () {
                            // TODO: cart bloc se AddToCartEvent bhejna hai
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppDimensions.xl),

                  // ===== Explore Categories (1:284) =====
                  Text('Explore Categories', style: AppTextStyles.headlineMd.copyWith(color: AppColors.onSurface)),
                  const SizedBox(height: AppDimensions.sm),
                  CategoryGrid(
                    categories: feed.categories,
                    onCategoryTap: (category) {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CategoriesScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: AppDimensions.xl),

                  // ===== Stores Near You (1:309) =====
                  _SectionHeader(title: 'Stores Near You', onSeeAll: () {}),
                  const SizedBox(height: AppDimensions.sm),
                  SizedBox(
                    height: 272,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: feed.stores.length,
                      separatorBuilder: (_, __) => const SizedBox(width: AppDimensions.md),
                      itemBuilder: (context, i) {
                        final store = feed.stores[i];
                        return StoreCard(
                          store: store,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => StoreProductsScreen(storeId: store.id, storeName: store.name),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // ===== Bottom Nav Bar (1:360) =====
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _navIndex,
        onTap: (i) => AppRouter.navigateToTab(context, i),
      ),
    );
  }
}

/// Chhota reusable header — "Deals of the Week   See All" jaisi rows
/// baar-baar likhne ke bajaye ek private widget bana diya.
class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.headlineMd.copyWith(color: AppColors.onSurface)),
        TextButton(
          onPressed: onSeeAll,
          style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 24)),
          child: Text('See All', style: AppTextStyles.labelSm.copyWith(color: AppColors.primary)),
        ),
      ],
    );
  }
}
