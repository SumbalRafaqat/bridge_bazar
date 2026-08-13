import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_home_feed_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

/// HomeBloc: screen khulte hi HomeFeedRequested event fire hoga
/// (dekhein home_screen.dart mein BlocProvider..add()), yeh Loading
/// state degi, phir 4 APIs (parallel) complete hote hi Loaded ya
/// Error state degi.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeFeedUseCase getHomeFeedUseCase;

  HomeBloc({required this.getHomeFeedUseCase}) : super(const HomeLoading()) {
    on<HomeFeedRequested>(_onHomeFeedRequested);
  }

  Future<void> _onHomeFeedRequested(
    HomeFeedRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      final feed = await getHomeFeedUseCase.call();
      emit(HomeLoaded(feed));
    } catch (e) {
      emit(HomeError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
