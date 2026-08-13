import 'package:equatable/equatable.dart';

/// AuthEvent: Login aur Signup dono screens isi BLoC ko share karengi,
/// is liye do alag events hain — AuthBloc dono ko handle karega.
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// "Log In" button dabane par fire hota hai.
class LoginRequested extends AuthEvent {
  final String emailOrPhone;
  final String password;

  const LoginRequested({required this.emailOrPhone, required this.password});

  @override
  List<Object?> get props => [emailOrPhone, password];
}

/// "Create Account" button dabane par fire hota hai.
class SignupRequested extends AuthEvent {
  final String fullName;
  final String email;
  final String phone;
  final String password;

  const SignupRequested({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
  });

  @override
  List<Object?> get props => [fullName, email, phone, password];
}
