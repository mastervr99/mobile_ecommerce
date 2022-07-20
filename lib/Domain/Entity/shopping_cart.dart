import 'package:flutter/material.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';

class ShoppingCart extends ChangeNotifier {
  final List<Product> _cartItems = [];

  addItem(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  getAllCartItems() {
    return _cartItems;
  }
}
