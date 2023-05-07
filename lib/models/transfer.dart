// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bytebank/models/contact.dart';

class Transfer {
  final String id;
  final double value;
  final Contact contact;
  Transfer({
    required this.id,
    required this.value,
    required this.contact,
  });

  @override
  String toString() => 'Transfer(id: $id, value: $value, contact: $contact)';

  Transfer copyWith({
    String? id,
    double? value,
    Contact? contact,
  }) {
    return Transfer(
      id: id ?? this.id,
      value: value ?? this.value,
      contact: contact ?? this.contact,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'contact': contact.toMap(),
    };
  }

  factory Transfer.fromMap(Map<String, dynamic> map) {
    return Transfer(
      id: map['id'] as String,
      value: map['value'] as double,
      contact: Contact.fromMap(map['contact'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transfer.fromJson(String source) =>
      Transfer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Transfer other) {
    if (identical(this, other)) return true;

    return other.id == id && other.value == value && other.contact == contact;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode ^ contact.hashCode;
}
