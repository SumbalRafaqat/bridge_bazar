import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// AuthBloc: Login aur Signup, DONO screens ka "brain" yehi hai
/// (ek hi BLoC use karna is liye behtar hai kyunke dono ka
/// end-result same hai: "user authenticate ho gaya").
///
/// Flow: UI event bhejti hai (LoginRequested/SignupRequested)
/// → BLoC state emit karta hai (Loading → Success/Failure)
/// → UI (BlocConsumer) us state ko sun kar reaction deti hai
///   (navigate karna, ya error dikhana).
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;

  AuthBloc({required this.loginUseCase, required this.signupUseCase})
      : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignupRequested>(_onSignupRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await loginUseCase.call(
        emailOrPhone: event.emailOrPhone,
        password: event.password,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      // e.toString() mein "Exception: " prefix hota hai, usay hata rahe hain.
      emit(AuthFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> _onSignupRequested(
    SignupRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await signupUseCase.call(
        fullName: event.fullName,
        email: event.email,
        phone: event.phone,
        password: event.password,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
