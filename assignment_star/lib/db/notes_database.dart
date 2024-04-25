import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/note.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  //open connection to database
  Future<Database> get database async {
    //return database if already exist
    if (_database != null) return _database!;

    //create database called 'notes.db'
    _database = await _initDB('notes3.db');
    return _database!;
  }

    //initialize database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    //open database
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  //database schema to create database, only used for when database is not created
  Future _createDB(Database db, int version) async {
    //type per object
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';


  // execute database creating
    await db.execute('''
CREATE TABLE $tableNotes ( 
  ${NoteFields.id} $idType, 
  ${NoteFields.rating} $integerType,
  ${NoteFields.isImportant} $boolType,
  ${NoteFields.number} $integerType,
  ${NoteFields.title} $textType,
  ${NoteFields.address} $textType,
  ${NoteFields.description} $textType,
  ${NoteFields.time} $textType
  )
''');
  }

  //create database record
  Future<Note> create(Note note) async {
    final db = await instance.database;

    //if you want to add specific sqlite statements
    // final json = note.toJson();
    // final columns = '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values = '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db.rawInsert('INSERT INTO table ($columns) VALUES ($values)');

    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  //read database record
  Future<Note> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      //prevent sql injections
      whereArgs: [id],
    );

    //if returning some value, so no error
    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      //if maps is empty, couldn't find our object
      throw Exception('ID $id not found');
    }
  }

  //read multiple notes
  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;

    //order list based on time ascending order
    final orderBy = '${NoteFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    //read whole list
    final result = await db.query(tableNotes, orderBy: orderBy);

    //convert all json objects to notes objects
    return result.map((json) => Note.fromJson(json)).toList();
  }

  //update database record
  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      //prevent sql injections
      whereArgs: [note.id],
    );
  }

  //delete database record
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  //close database
  Future close() async {
    final db = await instance.database;

    db.close();
  }
}