import '../../domain/entities/user_entity.dart';

/// UserModel: yeh UserEntity ka "JSON-aware" version hai.
/// Server se jo JSON aata hai, usay Dart object mein convert karne
/// (fromJson) aur wapas JSON banane (toJson) ka kaam yahan hota hai.
///
/// "extends UserEntity" — matlab UserModel khud bhi ek UserEntity hai,
/// is liye ise seedha domain/presentation layer ko bhi de sakte hain.
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.phone,
  });

  /// Server ke JSON response ko Dart object mein badalta hai.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      fullName: json['full_name'] ?? json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  /// Dart object ko wapas JSON (server ko bhejne ke liye) banata hai.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
    };
  }
}
