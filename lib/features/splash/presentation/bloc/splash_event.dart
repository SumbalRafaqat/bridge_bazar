import 'package:equatable/equatable.dart';

/// SplashEvent: yeh woh "actions" hain jo Splash screen par ho saktay hain.
/// Abhi humare paas sirf ek event hai: "app started ho gayi, timer start karo".
/// Jab bhi koi naya trigger chahiye ho (jaise "retry"), yahan naya event
/// class banayenge.
abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

/// Yeh event tab fire hota hai jab SplashScreen sabse pehli baar build hoti hai.
class SplashStarted extends SplashEvent {
  const SplashStarted();
}
