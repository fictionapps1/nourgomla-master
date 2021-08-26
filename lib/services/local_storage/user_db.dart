import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../consts/user_profile_consts.dart';
import '../../models/user.dart';

class UserDbHelper {
  UserDbHelper._();
  static final UserDbHelper db = UserDbHelper._();
  static Database _database;

  Future<Database> getDatabase() async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'User.db');
    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE $USER_TABLE (
        $COLUMN_UID INTEGER NOT NULL,
        $COLUMN_LANGUAGE_ID,
        $COLUMN_GENDER INTEGER NOT NULL,
        $COLUMN_STATUS INTEGER NOT NULL,
        $COLUMN_ROLE INTEGER NOT NULL,
        $COLUMN_FN TEXT NOT NULL,
        $COLUMN_PASSWORD,
        $COLUMN_LN TEXT NOT NULL,
        $COLUMN_EMAIL TEXT NOT NULL,
        $COLUMN_IS_ACTIVATED INTEGER NOT NULL,
        $COLUMN_PHONE_VERIFIED INTEGER NOT NULL,
        $COLUMN_PHONE TEXT NOT NULL)''');
    });
  }

  insertUserData(User user) async {
    var dbClient = await getDatabase();
    await dbClient.insert(USER_TABLE, user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  updateUserData(User user) async {
    var dbClient = await getDatabase();
    await dbClient.update(USER_TABLE, user.toJson(),
        where: '$COLUMN_UID =?', whereArgs: [user.id]);
  }

  updatePassword(String userId,String password) async {
    var dbClient = await getDatabase();
    await dbClient.update(USER_TABLE, {COLUMN_PASSWORD:password},
        where: '$COLUMN_UID =?', whereArgs: [userId]);
  }

  deleteUserData(User user) async {
    var dbClient = await getDatabase();
    await dbClient
        .delete(USER_TABLE, where: '$COLUMN_UID =?', whereArgs: [user.id]);
  }

  Future<User> getUserData() async {
    var dbClient = await getDatabase();
    List<Map> userData = await dbClient.query(USER_TABLE);
    print('USER DATA=====> $userData');
    if (userData.isNotEmpty) {
      User user = User.fromJson(userData[0]);
      return user;
    }
    return User();
  }
}
