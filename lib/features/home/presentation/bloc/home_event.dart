import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

/// Home screen khulte hi (ya pull-to-refresh par) fire hota hai.
class HomeFeedRequested extends HomeEvent {
  const HomeFeedRequested();
}
