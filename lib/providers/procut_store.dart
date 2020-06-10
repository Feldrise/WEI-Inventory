import 'package:flutter/cupertino.dart';
import 'package:wei_inventory/models/product.dart';

class ProductStore with ChangeNotifier {
  ProductStore({@required Product product}) : _product = product;

  final Product _product;

  Map<String, dynamic> get productMap => _product.toMap();

  String get name => _product.name;
  int get quantity => _product.quantity;

  void updateName(String newName) {
    _product.name = newName;

    notifyListeners();
  }

  void addOne() {
    _product.quantity++;
    notifyListeners();
  }

  void removeOne() {
    _product.quantity--;
    notifyListeners();
  }
}