import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

/// SplashBloc: yeh "brain" hai Splash screen ka.
///
/// KAISE KAAM KARTA HAI (BLoC pattern):
/// 1. UI ek EVENT bhejti hai (SplashStarted)
/// 2. BLoC us event ko "on<SplashStarted>" handler mein pakarta hai
/// 3. BLoC kuch kaam karta hai (yahan: 2 second wait karna)
/// 4. BLoC naya STATE emit karta hai (SplashNavigateToLogin)
/// 5. UI ka BlocListener yeh naya state "sunta" hai aur Navigator se
///    agli screen par le jaata hai.
///
/// YEH FAYDA HAI: UI code (SplashScreen) mein koi business logic
/// (Future.delayed, condition checks) nahi likhna padta — sirf UI dikhani hai.
/// Logic yahan alag file mein hai, is liye easily test bhi ho sakti hai.
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashInitial()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(const SplashLoading());

    // Abhi ke liye 2 second ka artificial delay (jaise logo dikhana).
    // Baad mein yahan "check login token" jaisi asli logic bhi aa sakti hai.
    await Future.delayed(const Duration(seconds: 2));

    emit(const SplashNavigateToLogin());
  }
}
