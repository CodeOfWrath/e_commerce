import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    super.username = '',
    super.firstName = '',
    super.lastName = '',
    super.image = '',
    super.accessToken,
    super.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      email: json['email']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? json['first_name']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? json['last_name']?.toString() ?? '',
      image: json['image']?.toString() ?? json['avatar']?.toString() ?? '',
      accessToken: json['accessToken']?.toString() ?? json['token']?.toString(),
      refreshToken: json['refreshToken']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
