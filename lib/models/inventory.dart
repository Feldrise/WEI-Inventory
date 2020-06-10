import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wei_inventory/helpers/database_helper.dart';
import 'package:wei_inventory/models/product.dart';
import 'package:wei_inventory/providers/procut_store.dart';

class Inventory {
  Inventory();
  Inventory.withName({@required this.name});

  int id;
  String name = "";

  List<ProductStore> products = []; 

  Inventory.fromMap(Map<String, dynamic> map) :
    id = map[inventoryColumnId] as int,
    name = map[inventoryColumnName] as String {
      for (final dynamic productMap in jsonDecode(map['products'] as String) as List<dynamic>) {
        products.add(ProductStore(product: Product.fromMap(productMap as Map<String, dynamic>)));
      }
    }

  Map<String, dynamic> toMap() {
    final List<Map<String, dynamic>> productsMap = [];
    
    for (final ProductStore store in products) {
      productsMap.add(store.productMap);
    }

    return <String, dynamic>{
      'name': name,
      'products': jsonEncode(productsMap)
    };
  }
}