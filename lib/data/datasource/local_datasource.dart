import 'package:note_project/data/model/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  final String dbName = 'note_database.db';
  final String tableName = 'notes';

  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        '''CREATE TABLE $tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          content TEXT,
          createdAt INTEGER
        )''',
      );
    });
  }

  // Insert data
  Future<int> insertNote(Note note) async {
    final db = await _openDatabase();
    return await db.insert(tableName, note.toMap());
  }

  // Get All Notes
  Future<List<Note>> getNote() async {
    final db = await _openDatabase();
    final maps = await db.query(tableName, orderBy: 'createdAt DESC');
    print("Maps retrieved from database: $maps");
    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  // Get Note by Id
  Future<Note> getNoteById(int id) async {
    final db = await _openDatabase();
    final maps = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Note.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  // Update Note by Id
  Future<int> updateNoteById(Note note) async {
    final db = await _openDatabase();
    return await db
        .update(tableName, note.toMap(), where: 'id=?', whereArgs: [note.id]);
  }

  Future<int> deleteNoteById(int id) async {
    final db = await _openDatabase();
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
