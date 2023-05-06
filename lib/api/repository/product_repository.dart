import 'dart:convert';

import 'package:clothing_ecommerce/api/models/category.dart';
import 'package:clothing_ecommerce/api/models/product.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  const ProductRepository(this._client);
  final http.Client _client;

  final String _baseUrl = "https://fakestoreapi.com/products";

  Future<List<Product>> getProducts() async {
    var response = await _client.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List<dynamic>;
      var products = jsonResponse.map((e) => Product.fromJson(e)).toList();
      return products;
    } else {
      throw Error();
    }
  }

  Future<Category> getCategories() async {
    var response = await _client.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List<String>;
      var categories = Category.fromJson(jsonResponse);
      return categories;
    } else {
      throw Error();
    }
  }
}
