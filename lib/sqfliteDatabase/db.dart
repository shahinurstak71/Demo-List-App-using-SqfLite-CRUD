import 'dart:ffi';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqfliteapp/models/model.dart';
import 'dart:async';

class StudentManeger {
  Database _database;
  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(join(await getDatabasesPath(), "ss.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE  student(id INTEGER PRIMARY KEY autoincrement, name TEXT, subject TEXT)",
        );
      });
    }
  }

  Future<int> insertStudent(Student student) async {
    await openDb();
    return await _database.insert("student", student.toMap());
  }

  Future<List<Student>> getStudentList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('student');
    return List.generate(maps.length, (i) {
      return Student(
          id: maps[i]['id'],
          name: maps[i]['name'],
          subject: maps[i]['subject']);
    });
  }

  Future<int> updateStudent(Student student) async {
    await openDb();
    return await _database.update('student', student.toMap(),
        where: "id = ?", whereArgs: [student.id]);
  }

  Future<Void> deleteStudent(int id) async {
    await openDb();
    await _database.delete('student', where: "id = ?", whereArgs: [id]);
  }
}
