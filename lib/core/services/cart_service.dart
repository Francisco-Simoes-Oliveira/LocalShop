import 'package:shoplocal/features/product/models/product_model.dart';

class CartService {
  static final List<Map<String, dynamic>> _items = [];

  static List<Map<String, dynamic>> get items => List.unmodifiable(_items);

  static void add(Product product, int quantity) {
    _items.add({
      'product': product,
      'quantity': quantity,
      'addedAt': DateTime.now(),
    });
  }
}
