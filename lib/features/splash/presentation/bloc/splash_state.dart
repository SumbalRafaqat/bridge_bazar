import 'package:equatable/equatable.dart';

/// SplashState: yeh batata hai ke Splash screen ki "current situation" kya hai.
/// UI (BlocBuilder) inhi states ko dekh kar decide karti hai ke kya dikhana hai.
abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

/// Initial state — jab tak koi event fire nahi hota
class SplashInitial extends SplashState {
  const SplashInitial();
}

/// Loading state — logo dikha rahe hain, timer chal raha hai
class SplashLoading extends SplashState {
  const SplashLoading();
}

/// Yeh state batati hai: "ab agli screen (Login) par navigate kar do"
/// BlocListener isay sunta hai aur Navigator.push karta hai.
class SplashNavigateToLogin extends SplashState {
  const SplashNavigateToLogin();
}
