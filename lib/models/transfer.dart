import 'dart:convert';

import 'package:bytebank/models/contact.dart';

class Transfer {
  final double value;
  final Contact contact;
  Transfer({
    required this.value,
    required this.contact,
  });

  @override
  String toString() => 'Transfer(value: $value, contact: $contact)';

  Transfer copyWith({
    double? value,
    Contact? contact,
  }) {
    return Transfer(
      value: value ?? this.value,
      contact: contact ?? this.contact,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'contact': contact.toMap(),
    };
  }

  factory Transfer.fromMap(Map<String, dynamic> map) {
    return Transfer(
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

    return other.value == value && other.contact == contact;
  }

  @override
  int get hashCode => value.hashCode ^ contact.hashCode;
}
