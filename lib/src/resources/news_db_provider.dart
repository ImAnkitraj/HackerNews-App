import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';//to work with temporary memory of mobile devices
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'repository.dart';


class NewsDbProvider implements Source, Cache {
  //Database word is coming sqflite package
  Database db;
   
  //Constructor to initialise init function
  NewsDbProvider(){
    init();
  }

  //Todo - store and fetch top ids
  Future<List<int>> fetchTopIds(){
    return null;
  }

  void init () async{
    Directory documentaryDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentaryDirectory.path, "items.db");//full path of directory and then our folder name

    //Creating the database
    db = await openDatabase( //sqflite package
      path,
      version: 1,
      onCreate: (Database newDb, int version){ //Only called very first time 
      //to write multiline string we use 3 quotes
        newDb.execute("""
        CREATE TABLE Items
        (
          id INTEGER PRIMARY KEY,
          type TEXT,
          by TEXT,
          time INTEGER,
          text TEXT,
          parent INTEGER,
          kids BLOB,
          dead INTEGER,
          deleted INTEGER,
          url TEXT,
          score INTEGER,
          title TEXT,
          descendants INTEGER
        )
        """);
      }
    );
  }

  Future<ItemModel> fetchItem (int id) async{
    final maps = await db.query(
      "Items",
      //to fetch on column columns:['title'],
      columns:null,
      where: "id = ?",//avoiding sql injection
      whereArgs: [id],//list of arguments
    );
    if (maps.length>0){
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  Future<int> addItem (ItemModel item) {
    return db.insert(
      "Items",
      item.toMap(),
      conflictAlgorithm:ConflictAlgorithm.ignore, 
    );
  }

  Future<int> clear(){
    return db.delete("Items");
  }
}

final newsDbProvider = NewsDbProvider();