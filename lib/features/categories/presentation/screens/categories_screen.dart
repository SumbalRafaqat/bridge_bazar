import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/search_bar_widget.dart';
import '../../data/datasources/category_remote_datasource.dart';
import '../../data/models/category_item_model.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../bloc/category_bloc.dart';
import '../bloc/category_event.dart';
import '../bloc/category_state.dart';

/// CategoriesScreen: Figma "Product Categories" (1:382) se EXACT match.
/// Compact TopAppBar → Search Bar → "Explore Categories" heading →
/// 2-column bento grid (7 image cards) → Bottom Nav Bar.
///
/// NOTE (assumption, bata raha hoon taake pata rahe): Figma ke is frame
/// mein bottom-nav ka 2nd tab "Inventory" naam se aaya (Figma ka
/// auto-naming quirk lagta hai — jaisa hum pehle discuss kar chuke).
/// Maine poori app mein CONSISTENT rakhne ke liye wahi customer
/// AppBottomNavBar use kiya hai jo Home screen par bhi hai
/// (Home/Categories/Cart/Profile) — taake navigation confuse na kare.
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryBloc(
        getCategoriesUseCase: GetCategoriesUseCase(CategoryRepositoryImpl(CategoryRemoteDataSource())),
      )..add(const CategoriesRequested()),
      child: const _CategoriesView(),
    );
  }
}

class _CategoriesView extends StatefulWidget {
  const _CategoriesView();

  @override
  State<_CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<_CategoriesView> {
  final int _navIndex = 1; // "Categories" tab active

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      // ===== Header - Top App Bar (1:405) — compact version =====
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.location_on_outlined, size: 20, color: AppColors.onSurface),
              onPressed: () {
                // TODO: location picker
              },
            ),
            Text('BazaarBridge', style: AppTextStyles.labelLg.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.refresh_rounded, size: 20, color: AppColors.onSurface),
              onPressed: () => context.read<CategoryBloc>().add(const CategoriesRequested()),
            ),
          ],
        ),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }
          if (state is CategoryError) {
            return Center(child: Text(state.message, style: AppTextStyles.bodyLg.copyWith(color: AppColors.error)));
          }

          final categories = (state as CategoryLoaded).categories;

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.md, AppDimensions.lg, AppDimensions.md, AppDimensions.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ===== Search Section (1:416) =====
                const SearchBarWidget(),
                const SizedBox(height: AppDimensions.md),

                // ===== Section - Categories Header (1:422) =====
                Text('Explore Categories', style: AppTextStyles.displayLg.copyWith(color: AppColors.onSurface)),
                const SizedBox(height: AppDimensions.base * 2), // 8px
                Text(
                  'Find fresh groceries from local markets.',
                  style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: AppDimensions.md),

                // ===== Section - Bento Grid Categories (1:426) =====
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppDimensions.md, // 16px
                    crossAxisSpacing: AppDimensions.md,
                    childAspectRatio: 1, // square cards (Figma)
                  ),
                  itemBuilder: (context, i) => _CategoryBentoCard(category: categories[i]),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _navIndex,
        onTap: (i) {
          // TODO: Home/Cart/Profile screens ready hone par yahan
          // Navigator se un par jump karna hai.
        },
      ),
    );
  }
}

/// Bento card: image placeholder + neeche gradient + white bold title.
/// Real product photos Figma ke temp CDN se hain (expire ho jaate),
/// is liye colored placeholder + icon use kiya, TODO comment ke sath.
class _CategoryBentoCard extends StatelessWidget {
  final CategoryItemModel category;

  const _CategoryBentoCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Store Products screen par is category ke filter ke sath navigate karna.
      },
      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd), // 12px
          border: Border.all(color: AppColors.surfaceContainerHighest),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // TODO: Image.network(category.imageUrl) yahan lagana jab real photos milein.
            Container(color: category.accentColor.withOpacity(0.85)),
            Center(child: Icon(category.icon, size: 40, color: Colors.white.withOpacity(0.9))),
            // Bottom gradient (Figma: black 70% -> transparent)
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                ),
              ),
            ),
            Positioned(
              left: AppDimensions.md,
              right: AppDimensions.md,
              bottom: AppDimensions.md,
              child: Text(
                category.name,
                style: AppTextStyles.headlineMd.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
