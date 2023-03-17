import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';

class ContactsDao {
  static const String _contactsTable = 'contacts';
  static const String _contactsId = 'id';
  static const String _contactsName = 'name';
  static const String _contactsAccountNumber = 'account_number';
  static const String dbCreationQuery = """
            CREATE TABLE $_contactsTable(
              $_contactsId INTEGER PRIMARY KEY,
              $_contactsName TEXT,
              $_contactsAccountNumber INTEGER
            )
        """;

  Future<int> save({required String name, required String account}) {
    return getDatabase().then(
      (db) {
        return db.insert(_contactsTable, {
          _contactsName: name,
          _contactsAccountNumber: account,
        });
      },
    );
  }

  Future<List<Contact>> findAll() async {
    final db = await getDatabase();
    final result = await db.query(_contactsTable);
    return _toList(result);
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = [];
    for (Map<String, dynamic> row in result) {
      contacts.add(Contact.fromMap(row));
    }
    return contacts;
  }
}
