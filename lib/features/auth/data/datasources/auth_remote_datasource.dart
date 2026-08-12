import '../models/user_model.dart';

/// AuthRemoteDataSource: yahan ASAL API calls (http package se) hongi.
/// Abhi backend/API endpoint decide nahi hua, is liye "TODO" chhoda hai
/// aur ek MOCK response return kar raha hoon — taake UI/BLoC abhi se
/// test ho sake, bina backend ke.
///
/// Jab real backend milega, sirf yeh do functions (login/signup)
/// http.post(...) calls se replace karne honge — baaki poori app
/// (BLoC, UI) ko chhoona nahi padega.
class AuthRemoteDataSource {
  Future<UserModel> login({
    required String emailOrPhone,
    required String password,
  }) async {
    // TODO: Replace with real API call, e.g.:
    // final response = await ApiClient.post('/auth/login', body: {...});
    // return UserModel.fromJson(response);

    await Future.delayed(const Duration(seconds: 1)); // network simulate

    if (emailOrPhone.isEmpty || password.isEmpty) {
      throw Exception('Email/Phone aur Password required hain.');
    }

    return UserModel(
      id: 'mock_user_1',
      fullName: 'Test User',
      email: emailOrPhone,
      phone: '',
    );
  }

  Future<UserModel> signup({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    // TODO: Replace with real API call.
    await Future.delayed(const Duration(seconds: 1));

    return UserModel(
      id: 'mock_user_new',
      fullName: fullName,
      email: email,
      phone: phone,
    );
  }
}