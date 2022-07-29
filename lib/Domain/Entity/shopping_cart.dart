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

  getCartTotalPrice() async {
    var cartTotalPrice = 0.00;
    var cartItems = await getAllCartItems();

    for (var i = 0; i < await cartItems.length; i++) {
      var itemTotalPrice =
          await cartItems[i].getQuantity() * await cartItems[i].getPrice();

      cartTotalPrice += await itemTotalPrice;
    }

    //Limit decimals to 2
    cartTotalPrice = double.parse((await cartTotalPrice).toStringAsFixed(2));

    return await cartTotalPrice;
  }
}
