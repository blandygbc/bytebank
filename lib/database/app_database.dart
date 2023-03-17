import 'package:bytebank/database/contacts_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final dbPath = await getDatabasesPath();
  final fullPath = join(dbPath, 'bytebank.db');
  return openDatabase(
    fullPath,
    onCreate: (db, version) {
      db.execute(ContactsDao.dbCreationQuery);
    },
    version: 1,
    //onDowngrade: onDatabaseDowngradeDelete,
  );
}
