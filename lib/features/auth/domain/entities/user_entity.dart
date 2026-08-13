/// UserEntity: "pure" business object — koi JSON parsing logic yahan
/// nahi hoti. Yeh sirf batata hai ke ek User ke paas kya data hota hai.
/// UI aur business logic isi entity ke sath kaam karte hain,
/// (UserModel se seedha nahi — woh sirf data layer ke liye hai).
class UserEntity {
  final String id;
  final String fullName;
  final String email;
  final String phone;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
  });
}
