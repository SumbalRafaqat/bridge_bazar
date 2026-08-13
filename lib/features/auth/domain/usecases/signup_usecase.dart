import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// SignupUseCase: "Create Account" button dabane par yeh call hota hai.
class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future<UserEntity> call({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) {
    return repository.signup(
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
    );
  }
}
