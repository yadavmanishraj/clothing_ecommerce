import 'package:clothing_ecommerce/api/repository/product_repository.dart';
import 'package:clothing_ecommerce/models/products.dart';
import 'package:clothing_ecommerce/screens/favorites.dart';
import 'package:clothing_ecommerce/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  ProductRepository repository = ProductRepository(http.Client());
  runApp(
    ChangeNotifierProvider(
      create: (context) => Products(repository),
      child: const TestingApp(),
    ),
  );
}

final _routes = GoRouter(routes: [
  GoRoute(
      path: HomePage.route,
      builder: (context, state) {
        return  HomePage();
      }),
  GoRoute(
      path: Favoritepage.route,
      builder: (context, state) {
        return const Favoritepage();
      })
]);

class TestingApp extends StatelessWidget {
  const TestingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Testing Sample",
      theme: ThemeData(
          colorSchemeSeed: Colors.deepOrange,
          useMaterial3: true,
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 249, 248),
          fontFamily: "Inter"),
      routerConfig: _routes,
    );
  }
}
