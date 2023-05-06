import 'package:clothing_ecommerce/api/models/product.dart';
import 'package:clothing_ecommerce/models/products.dart';
import 'package:clothing_ecommerce/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    var products = Provider.of<Products>(context);

    if (products.cart.isEmpty) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.add_shopping_cart,
            size: 100,
          ),
          Text(
            "No items in shopping cart",
            style: TextStyle(fontSize: 20),
          )
        ],
      ));
    }
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<Product>>(
            future: Future.value(Set.from(products.cart).toList().cast()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CartItem(product: snapshot.data![index]),
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Subtotal"),
                  Text(
                    "\$${products.subtotal}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const AppButton(child: Text("Checkout"))
            ],
          ),
        )
      ],
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    var products = Provider.of<Products>(context);

    return Container(
      height: 80,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
              blurRadius: 5,
              offset: Offset(5, 5),
              spreadRadius: 5,
              color: Color.fromARGB(255, 255, 251, 246))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: Image.network(product.image),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 110, 110, 110),
                        fontSize: 12),
                  ),
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Provider.of<Products>(context, listen: false)
                        .removeFromCart(product);
                  },
                  icon: const Icon(Icons.remove),
                  color: Colors.primaries.first),
              Text(products.cart
                  .where((element) => element == product)
                  .length
                  .toString()),
              IconButton(
                onPressed: () {
                  products.addToCart(product);
                },
                icon: const Icon(Icons.add),
                color: Colors.primaries.first,
              )
            ],
          )
        ],
      ),
    );
  }
}
