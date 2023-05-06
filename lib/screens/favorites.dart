import 'package:clothing_ecommerce/models/favorites.dart';
import 'package:clothing_ecommerce/models/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favoritepage extends StatelessWidget {
  const Favoritepage({super.key});

  static String route = '/favorite_paeg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: Consumer<Products>(
        builder: (context, value, child) => ListView.builder(
          itemCount: value.cart.length,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (context, index) => FavoriteItemTile(
            itemNo: index,
          ),
        ),
      ),
    );
  }
}

class FavoriteItemTile extends StatelessWidget {
  final int itemNo;

  const FavoriteItemTile({super.key, required this.itemNo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('Item $itemNo'),
        key: Key("favorite_text$itemNo"),
        trailing: IconButton(
          key: Key("remove_icon_$itemNo"),
          icon: const Icon(Icons.remove_shopping_cart),
          onPressed: () {},
        ),
      ),
    );
  }
}
