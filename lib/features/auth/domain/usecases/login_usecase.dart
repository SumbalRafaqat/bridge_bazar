import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// LoginUseCase: "ek business action = ek class" pattern.
/// Iska sirf ek kaam hai — login karna. BLoC isay call karega,
/// yeh repository ko call karega.
///
/// FAYDA: agar login se pehle/baad koi extra business rule add
/// karni ho (jaise "login ke baad last_login_time save karo"),
/// to woh logic sirf yahan likhni hai — bloc ya repository ko
/// chhedna nahi padega.
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call({
    required String emailOrPhone,
    required String password,
  }) {
    return repository.login(emailOrPhone: emailOrPhone, password: password);
  }
}