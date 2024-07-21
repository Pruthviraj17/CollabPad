// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  final String? username;
  final String? email;
  final String? image;

  UserModel({
    this.username,
    this.email,
    this.image,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'image': image,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      image: json['image'],
    );
  }
}
