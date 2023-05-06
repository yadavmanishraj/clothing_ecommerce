import 'package:clothing_ecommerce/models/favorites.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing App Provider', () {
    var favorites = Favorites();

    test("A new item should be added", () {
      var number = 23;
      favorites.add(number);
      expect(favorites.items.contains(number), true);
    });

    test("An item should be removed", () {
      var number = 45;
      favorites.add(number);
      expect(favorites.items.contains(number), true);
      favorites.remove(number);
      expect(favorites.items.contains(number), false);
    });
  });
}
