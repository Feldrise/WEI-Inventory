import 'dart:core';

class Product {
  Product();
  Product.withName({this.name});

  String name = "";
  int quantity = 1;

  Product.fromMap(Map<String, dynamic> map) :
    name = map['name'] as String,
    quantity = map['quantity'] as int;
    
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'quantity': quantity
    };
  }
}