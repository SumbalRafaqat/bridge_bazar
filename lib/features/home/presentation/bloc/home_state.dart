import 'package:equatable/equatable.dart';
import '../../domain/usecases/get_home_feed_usecase.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final HomeFeed feed;
  const HomeLoaded(this.feed);
  @override
  List<Object?> get props => [feed];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
  @override
  List<Object?> get props => [message];
}
