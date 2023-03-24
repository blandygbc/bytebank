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
}
