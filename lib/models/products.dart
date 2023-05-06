import 'dart:collection';

import 'package:clothing_ecommerce/api/models/product.dart';
import 'package:clothing_ecommerce/api/repository/product_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Products extends ChangeNotifier {
  Products(this._repository);
  final List<Product> _cart = [];
  final List<Product> _favorites = [];
  final List<String> category = UnmodifiableListView(
      ["electronics", "jewelery", "men's clothing", "women's clothing"]);
  final List<Product> _products = [];

  List<Product> get cart => UnmodifiableListView(_cart);
  List<Product> get favorites => UnmodifiableListView(_favorites);
  double get subtotal {
    if (cart.isEmpty) return 0;
    return double.parse(cart
        .map((e) => e.price)
        .toList()
        .reduce((value, element) => value + element)
        .toStringAsFixed(3));
  }

  final ProductRepository _repository;

  Future<List<Product>> get products async {
    if (_products.isNotEmpty) {
      return UnmodifiableListView(_products);
    }
    return _repository.getProducts();
  }

  void addToCart(Product productId) {
    _cart.add(productId);
    notifyListeners();
  }

  void removeFromCart(Product productId) {
    _cart.remove(productId);
    notifyListeners();
  }
}
