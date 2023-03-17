import 'package:bytebank/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(dbCreationQuery);
      },
      version: 1,
      //onDowngrade: onDatabaseDowngradeDelete,
    );
  });
}

Future<int> save({required String name, required String account}) {
  return getDatabase().then(
    (db) {
      return db.insert(contactsTable, {
        contactsName: name,
        contactsAccountNumber: account,
      });
    },
  );
}

Future<List<Contact>> findAll() async {
  final db = await getDatabase();
  final maps = await db.query(contactsTable);
  final List<Contact> contacts = [];
  for (Map<String, dynamic> map in maps) {
    contacts.add(Contact.fromMap(map));
  }
  return contacts;
}

const String contactsTable = 'contacts';
const String contactsId = 'id';
const String contactsName = 'name';
const String contactsAccountNumber = 'account_number';
const String dbCreationQuery = """
            CREATE TABLE contacts(
              id INTEGER PRIMARY KEY,
              name TEXT,
              account_number INTEGER
            )
        """;
