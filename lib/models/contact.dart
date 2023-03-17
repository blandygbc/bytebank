// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Contact {
  final int id;
  final String name;
  final int account;

  Contact({
    required this.id,
    required this.name,
    required this.account,
  });

  Contact copyWith({
    int? id,
    String? name,
    int? account,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      account: account ?? this.account,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'account_number': account,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] as int,
      name: map['name'] as String,
      account: map['account_number'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Contact(id: $id, name: $name, account: $account)';

  @override
  bool operator ==(covariant Contact other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.account == account;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ account.hashCode;
}
