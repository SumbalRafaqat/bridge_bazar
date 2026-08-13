import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Shuru mein / form khaali ho to yeh state hoti hai.
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Jab tak API call chal rahi ho (button par spinner dikhega).
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Login/Signup successful — UI isay "sun" kar Home screen kholega.
class AuthSuccess extends AuthState {
  final UserEntity user;

  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

/// Kuch galat ho gaya (galat password, network error, etc.)
/// message UI mein SnackBar/error text ke tor par dikhaya jayega.
class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
