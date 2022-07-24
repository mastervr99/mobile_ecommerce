import 'package:flutter/material.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/shopping_cart_item_repository.dart';

class ShoppingCart extends ChangeNotifier {
  late ShoppingCartItemRepository shoppingCartItemRepository;

  setItemRepository(ShoppingCartItemRepository shoppingCartItemRepository) {
    this.shoppingCartItemRepository = shoppingCartItemRepository;
  }

  getAllCartItems() async {
    var _cartItems = [];
    await shoppingCartItemRepository.init();
    _cartItems = await shoppingCartItemRepository.retrieveAllItems();
    await shoppingCartItemRepository.close();
    return await _cartItems;
  }
}
