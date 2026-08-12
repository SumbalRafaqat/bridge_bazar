import '../entities/user_entity.dart';

/// AuthRepository: yeh sirf ek "contract/interface" hai — ismein
/// koi actual code (http call, etc.) nahi hota, sirf yeh define hota
/// hai ke "login" aur "signup" naam ke functions ka hona zaroori hai.
///
/// FAYDA: BLoC ya UseCase isi abstract class ka reference rakhte hain,
/// asal implementation (AuthRepositoryImpl) ka nahi. Kal ko agar
/// backend badal jaye (REST se GraphQL), sirf AuthRepositoryImpl
/// badlega — BLoC ko pata bhi nahi chalega.
abstract class AuthRepository {
  Future<UserEntity> login({
    required String emailOrPhone,
    required String password,
  });

  Future<UserEntity> signup({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  });
}