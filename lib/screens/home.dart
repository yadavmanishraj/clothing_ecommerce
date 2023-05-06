import 'package:clothing_ecommerce/api/models/product.dart';
import 'package:clothing_ecommerce/models/products.dart';
import 'package:clothing_ecommerce/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static String route = '/';

  @override
  Widget build(BuildContext context) {
    var products = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.location_pin,
              size: 15,
              color: Colors.grey,
            ),
            Text("Kathmandu"),
          ],
        ),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            fontSize: 15, color: Colors.grey, fontFamily: "Inter"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notification_add))
        ],
      ),
      drawer: const Drawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Explore",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const Text(
                    "Best marketplace ever for shopping",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  )
                ],
              )),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SearchField(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                products.category.map((e) => CategoryItem(text: e)).toList(),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "New Arrival",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  TextButton(onPressed: () {}, child: const Text("More"))
                ],
              ),
              FutureBuilder<List<Product>>(
                  future: products.products,
                  initialData: const [],
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: 250,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) =>
                                ProductItem(product: snapshot.data![index])),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.primaries.first,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_checkout), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);

    return SizedBox(
      width: 250,
      child: Card(
        elevation: 4,
        surfaceTintColor: Colors.white,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Expanded(
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.network(
                      product.image,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      Text(
                        product.title,
                        maxLines: 1,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis, fontSize: 16),
                      ),
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ]),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    !products.cart.contains(product.id)
                        ? products.addToCart(product.id)
                        : products.removeFromCart(product.id);
                  },
                  icon: products.cart.contains(product.id)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.deepOrange,
                        )
                      : const Icon(Icons.favorite_border)),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                "assets/img/$text.png",
                fit: BoxFit.cover,
              ),
            ),
            const Text(
              "Dress",
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
