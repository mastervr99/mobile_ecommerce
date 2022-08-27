import 'package:flutter/material.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/shopping_cart_item_repository.dart';

class ShoppingCart extends ChangeNotifier {
  late ShoppingCartItemRepository shoppingCartItemRepository;

  setItemRepository(ShoppingCartItemRepository shoppingCartItemRepository) {
    this.shoppingCartItemRepository = shoppingCartItemRepository;
  }

  getAllCartItems() async {
    var _cartItems = [];
    _cartItems = await shoppingCartItemRepository.retrieveAllItems();
    return await _cartItems;
  }

  getCartTotalPrice() async {
    var cartTotalPrice = 0.00;

    var cartItems = await shoppingCartItemRepository.retrieveAllItems();

    for (var i = 0; i < await cartItems.length; i++) {
      var itemTotalPrice =
          await cartItems[i].getQuantity() * await cartItems[i].getPrice();

      cartTotalPrice += await itemTotalPrice;
    }

    //Limit decimals to 2
    cartTotalPrice = double.parse((await cartTotalPrice).toStringAsFixed(2));

    return await cartTotalPrice;
  }

  getItemsTotalQuantity() async {
    var itemsTotalQuantity = 0;

    var cartItems = await shoppingCartItemRepository.retrieveAllItems();

    for (var i = 0; i < await cartItems.length; i++) {
      int itemQuantity = await cartItems[i].getQuantity();

      itemsTotalQuantity += await itemQuantity;
    }

    return await itemsTotalQuantity;
  }
}
