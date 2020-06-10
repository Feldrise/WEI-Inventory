import 'package:flutter/material.dart';
import 'package:wei_inventory/helpers/database_helper.dart';
import 'package:wei_inventory/models/inventory.dart';
import 'package:wei_inventory/providers/inventory_store.dart';

class InventoriesStore with ChangeNotifier {
  InventoriesStore();
  
  bool _initialized = false;
  final List<InventoryStore> _inventories = [];

  Future _initialize() async {
    final DatabaseHelper databaseHelper = DatabaseHelper.instance;
    for (final Inventory inventory in await databaseHelper.queryAllInventories()) {
      _inventories.add(InventoryStore(inventory: inventory));
    }

    _initialized = true;
  }

  Future<List<InventoryStore>> get inventories async {
    if (!_initialized) {
      await _initialize();
    }

    return _inventories;
  }

  Future addNewInventory(String inventoryName) async {
    final Inventory inventory = Inventory.withName(name: inventoryName);

    final DatabaseHelper databaseHelper = DatabaseHelper.instance;
    inventory.id = await databaseHelper.insertInventory(inventory);

    _inventories.add(InventoryStore(inventory: inventory));
    
    notifyListeners();
  }

  Future deleteInventory(InventoryStore inventoryStore) async {
    inventoryStore.deleteInventory();
    _inventories.remove(inventoryStore);

    notifyListeners();
  }
  
}