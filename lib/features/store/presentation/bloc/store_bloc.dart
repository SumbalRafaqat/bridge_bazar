import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_store_products_usecase.dart';
import 'store_event.dart';
import 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final GetStoreProductsUseCase getStoreProductsUseCase;

  StoreBloc({required this.getStoreProductsUseCase}) : super(const StoreLoading()) {
    on<StoreProductsRequested>(_onProductsRequested);
  }

  Future<void> _onProductsRequested(StoreProductsRequested event, Emitter<StoreState> emit) async {
    emit(const StoreLoading());
    try {
      final products = await getStoreProductsUseCase.call(event.storeId);
      emit(StoreLoaded(products));
    } catch (e) {
      emit(StoreError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
