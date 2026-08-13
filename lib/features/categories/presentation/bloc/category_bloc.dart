import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryBloc({required this.getCategoriesUseCase}) : super(const CategoryLoading()) {
    on<CategoriesRequested>(_onCategoriesRequested);
  }

  Future<void> _onCategoriesRequested(
    CategoriesRequested event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const CategoryLoading());
    try {
      final categories = await getCategoriesUseCase.call();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
