import 'package:get_it/get_it.dart';

/// sl = "service locator" — poore app mein isi ek instance se
/// hum apni classes (repositories, datasources, etc.) "get" karenge.
final GetIt sl = GetIt.instance;

/// initDependencies(): app start hote hi main.dart mein ek dafa call hoga.
/// Jaise-jaise naye features (auth, home, product) banenge, unki
/// repositories/datasources/usecases yahan register karte jayenge.
Future<void> initDependencies() async {
  // Example (aage aane wale features ke liye):
  // sl.registerLazySingleton<ApiClient>(() => ApiClient());
  // sl.registerLazySingleton<LocalStorageService>(() => LocalStorageService());
}
