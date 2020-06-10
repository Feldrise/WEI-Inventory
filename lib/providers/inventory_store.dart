import 'package:flutter/cupertino.dart';
import 'package:wei_inventory/helpers/database_helper.dart';
import 'package:wei_inventory/models/inventory.dart';
import 'package:wei_inventory/models/product.dart';
import 'package:wei_inventory/providers/procut_store.dart';

class InventoryStore with ChangeNotifier {
  InventoryStore({@required Inventory inventory}): _inventory = inventory;

  final Inventory _inventory;

  int get count => _inventory.products.length;

  int get id => _inventory.id;
  String get name => _inventory.name;

  List<ProductStore> get products => _inventory.products;

  Future updateName(String newName) async {
    final DatabaseHelper databaseHelper = DatabaseHelper.instance;

    _inventory.name = newName;
    await databaseHelper.updateInventory(_inventory);

    notifyListeners();
  }

  Future addProduct(String productName) async {
    final DatabaseHelper databaseHelper = DatabaseHelper.instance;

    _inventory.products.add(ProductStore(product: Product.withName(name: productName)));
    await databaseHelper.updateInventory(_inventory);

    notifyListeners();
  }

  Future deleteProduct(ProductStore toRemove) async {
    final DatabaseHelper databaseHelper = DatabaseHelper.instance;

    _inventory.products.remove(toRemove);
    await databaseHelper.updateInventory(_inventory);

    notifyListeners();
  }

  Future saveInventory() async {
    final DatabaseHelper databaseHelper = DatabaseHelper.instance;

    await databaseHelper.updateInventory(_inventory);
  }

  Future deleteInventory() async {
    final DatabaseHelper databaseHelper = DatabaseHelper.instance;

    await databaseHelper.deleteInventory(_inventory);
  }
}