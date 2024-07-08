// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClassName {
  final String name;
  final String email;
  final String token;
  ClassName({
    required this.name,
    required this.email,
    required this.token,
  });

  ClassName copyWith({
    String? name,
    String? email,
    String? token,
  }) {
    return ClassName(
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'token': token,
    };
  }

  factory ClassName.fromMap(Map<String, dynamic> map) {
    return ClassName(
      name: map['name'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassName.fromJson(String source) => ClassName.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ClassName(name: $name, email: $email, token: $token)';

  @override
  bool operator ==(covariant ClassName other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.token == token;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ token.hashCode;
}
