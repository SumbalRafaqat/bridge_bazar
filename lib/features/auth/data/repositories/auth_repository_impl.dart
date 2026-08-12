import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

/// AuthRepositoryImpl: AuthRepository (contract) ki ASAL implementation.
/// Yeh sirf AuthRemoteDataSource ko call karta hai — abhi extra logic
/// nahi hai, lekin agar kal "local caching" (SharedPreferences mein
/// user save karna) add karni ho, to woh logic YAHAN aayegi —
/// BLoC ko pata nahi chalega.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> login({
    required String emailOrPhone,
    required String password,
  }) {
    return remoteDataSource.login(emailOrPhone: emailOrPhone, password: password);
  }

  @override
  Future<UserEntity> signup({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) {
    return remoteDataSource.signup(
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
    );
  }
}