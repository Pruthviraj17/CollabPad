// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RoomUser {
  final String? name;
  RoomUser({
    this.name,
  });

  RoomUser copyWith({
    String? name,
  }) {
    return RoomUser(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory RoomUser.fromMap(Map<String, dynamic> map) {
    return RoomUser(
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomUser.fromJson(String source) =>
      RoomUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RoomUser(name: $name)';

  @override
  bool operator ==(covariant RoomUser other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
