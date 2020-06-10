import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wei_inventory/models/inventory.dart';

const String tableInventories = "inventories";

const String inventoryColumnId = "_id";
const String inventoryColumnName = "name";
const String inventoryColumnProducts = "products";

class DatabaseHelper {
  static const _databaseName = "wei_stock_database";
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    return _initDatabase();
  }

  Future<Database> _initDatabase() async {
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, _databaseName);

    return openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate,
        /*onUpgrade: _onUpgrade,*/);
  }

  // SQL string to create the database 
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableInventories (
            $inventoryColumnId INTEGER PRIMARY KEY,
            $inventoryColumnName TEXT NOT NULL,
            $inventoryColumnProducts TEXT NOT NULL
          )
          ''');
  }

  Future<int> insertInventory(Inventory inventory) async {
    final Database db = await database;
    
    final int id = await db.insert(tableInventories, inventory.toMap());

    return id;
  } 

  Future updateInventory(Inventory inventory) async {
    final Database db = await database;

    db.update(tableInventories, inventory.toMap(),
      where: '$inventoryColumnId = ?',
      whereArgs: [inventory.id]
    );
  }

  Future deleteInventory(Inventory inventory) async {
    final Database db = await database;

    db.delete(tableInventories,
      where: '$inventoryColumnId = ?',
      whereArgs: [inventory.id]
    );
  }

  Future<Inventory> queryInventory(int id) async {
    final Database db = await database;

    final List<Map> maps = await db.query(tableInventories,
      columns: [inventoryColumnId,
                inventoryColumnName,
                inventoryColumnProducts],
      where: '$inventoryColumnId = ?',
      whereArgs: [id]
    );

    if (maps.isNotEmpty) {
      final Inventory inventory = Inventory.fromMap(maps.first as Map<String, dynamic>);

      return inventory;
    }

    return null;

  }

  Future<List<Inventory>> queryAllInventories() async {
    final Database db = await database;
    final List<Inventory> result = [];

    final List<Map> maps = await db.query(tableInventories,
      columns: [inventoryColumnId,
                inventoryColumnName,
                inventoryColumnProducts]
    );

    for (final inventory in maps) {
      final Inventory toAdd = Inventory.fromMap(inventory as Map<String, dynamic>);

      result.add(toAdd);
    }

    return result;
  }

}