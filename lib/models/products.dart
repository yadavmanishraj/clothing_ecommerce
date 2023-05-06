import 'dart:collection';

import 'package:clothing_ecommerce/api/models/product.dart';
import 'package:clothing_ecommerce/api/repository/product_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Products extends ChangeNotifier {
  Products(this._repository);
  final List<int> _cart = [];
  final List<int> _favorites = [];
  final List<String> category = UnmodifiableListView(
      ["electronics", "jewelery", "men's clothing", "women's clothing"]);

  List<int> get cart => UnmodifiableListView(_cart);
  List<int> get favorites => UnmodifiableListView(_favorites);

  final ProductRepository _repository;

  Future<List<Product>> get products => _repository.getProducts();

  void addToCart(int productId) {
    _cart.add(productId);
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _cart.remove(productId);
    notifyListeners();
  }
}
