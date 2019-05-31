import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';


import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../Models/StudyCardModel.dart';


class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();


static Database _database;

  Future<Database> get database async {
    if (_database != null)
    return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Cards ("
          "id INTEGER PRIMARY KEY,"
          "question TEXT,"
          "answer TEXT,"
          "card_deck TEXT"
          ")");
    });
  }


  newClient(StudyCard newStudyCard) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Cards");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Cards (id,question,answer,card_deck)"
        " VALUES (?,?,?,?)",
        [id, newStudyCard.question, newStudyCard.answer, 'Database Deck']);
    return raw;
  }

  Future<List<StudyCard>> getAllClients() async {
    final db = await database;
    var res = await db.query("Cards",where: "card_deck == Database Deck");
    List<StudyCard> list =
        res.isNotEmpty ? res.map((c) => StudyCard.fromJSON(c)).toList() : [];
    return list;
  }




}
