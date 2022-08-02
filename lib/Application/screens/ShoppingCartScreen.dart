import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/common_widgets/AppBarWidget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/CircularProgress.dart';
import 'package:mobile_ecommerce/Application/screens/OrderCheckoutScreen.dart';
import 'package:mobile_ecommerce/Application/usecases/remove_shopping_cart_item_usecase.dart';
import 'package:mobile_ecommerce/Application/usecases/update_shopping_cart_item_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/shopping_cart.dart';
import 'package:mobile_ecommerce/Domain/Entity/shopping_cart_item.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/shopping_cart_item_repository.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/shopping_cart_item_repository_sqflite_impl.dart';
import 'package:provider/provider.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingCart>(builder: (context, settings, child) {
      return Scaffold(
        appBar: appBarWidget(context),
        body: FutureBuilder(
          future: getAllCartItems(context),
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: _emptyShoppingCart(context)),
                      ),
                    ],
                  ),
                );
              case ConnectionState.waiting:
                return CircularProgress();
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: snapshot.data.isEmpty
                                ? _emptyShoppingCart(context)
                                : _CartList(),
                          ),
                        ),
                      ],
                    ),
                  );
            }
          },
        ),
      );
    });
  }
}

Widget _emptyShoppingCart(BuildContext context) {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 70,
        child: Container(
          color: Color(0xFFFFFFFF),
        ),
      ),
      Container(
        width: double.infinity,
        height: 250,
        child: Image.asset(
          "assets/images/empty_shopping_cart.png",
          height: 250,
          width: double.infinity,
        ),
      ),
      SizedBox(
        height: 40,
        child: Container(
          color: Color(0xFFFFFFFF),
        ),
      ),
      Container(
        width: double.infinity,
        child: Text(
          translate("label_empty_cart"),
          style: const TextStyle(
            color: Color(0xFF67778E),
            fontFamily: 'Roboto-Light.ttf',
            fontSize: 20,
            fontStyle: FontStyle.normal,
          ),
          textAlign: TextAlign.center,
        ),
      )
    ],
  );
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllCartItems(context),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return CircularProgress();
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(translate("label_shopping_cart"),
                                  style: Theme.of(context).textTheme.headline6),
                              _showCartTotalprice(context)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFAC252B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              child: Text(
                                translate("label_validate_shopping_cart"),
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            OrderCheckoutScreen()));
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      height: 20,
                      thickness: 1,
                      indent: 20,
                      endIndent: 0,
                      color: Color(0xFFAC252B),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 25),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.white,
                                    ),
                                    child: Image.network(
                                      "${snapshot.data[index].getImageUrl()}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${snapshot.data[index].getTitle()}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      Text(
                                        "${snapshot.data[index].getPrice()}" +
                                            translate("label_currency"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                      SizedBox(height: 15),
                                      MyCounter(
                                          shoppingCartItem:
                                              snapshot.data[index]),
                                      SizedBox(height: 15),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xFFAC252B),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                        ),
                                        child: Text(
                                          translate("label_remove_cart_item"),
                                          style: Theme.of(context)
                                              .textTheme
                                              .button!
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                        onPressed: () async {
                                          await removeCartItem(
                                              snapshot.data[index]);
                                          Navigator.pop(context);
                                          // CircularProgress();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      ShoppingCartScreen()));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
        }
      },
    );
  }
}

getAllCartItems(BuildContext context) async {
  ShoppingCartItemRepository shoppingCartItemRepository =
      ShoppingCartItemRepositorySqfliteImpl();

  var shoppingCart = context.watch<ShoppingCart>();

  await shoppingCart.setItemRepository(shoppingCartItemRepository);

  var shopppingCartItems = await shoppingCart.getAllCartItems();
  return await shopppingCartItems;
}

Widget _showCartTotalprice(BuildContext context) {
  return FutureBuilder(
    future: getCartTotalPrice(context),
    builder: (context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return Text(translate("label_currency") + "0.00",
              style: Theme.of(context).textTheme.headline6);
        case ConnectionState.waiting:
          return CircularProgress();
        default:
          if (snapshot.hasError)
            return Text('Error: ${snapshot.error}');
          else
            return Text(translate("label_currency") + snapshot.data.toString(),
                style: Theme.of(context).textTheme.headline6);
      }
    },
  );
}

getCartTotalPrice(BuildContext context) async {
  ShoppingCartItemRepository shoppingCartItemRepository =
      ShoppingCartItemRepositorySqfliteImpl();

  var shoppingCart = context.watch<ShoppingCart>();

  await shoppingCart.setItemRepository(shoppingCartItemRepository);

  var cartTotalPrice = await shoppingCart.getCartTotalPrice();
  return await cartTotalPrice;
}

class MyCounter extends StatefulWidget {
  ShoppingCartItem shoppingCartItem;
  MyCounter({Key? key, required this.shoppingCartItem}) : super(key: key);

  @override
  _MyCounterState createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: <Widget>[
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFAC252B),
              ),
              child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
            onTap: () async {
              if (widget.shoppingCartItem.getQuantity() > 0) {
                var decrementedQuantity =
                    widget.shoppingCartItem.getQuantity() - 1;

                widget.shoppingCartItem.setQuantity(decrementedQuantity);
                await updateCartItem(widget.shoppingCartItem);
                // setState(() {});

                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ShoppingCartScreen()));
              }
            },
          ),
          SizedBox(width: 15),
          Text(
            "${widget.shoppingCartItem.getQuantity()}",
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(width: 15),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFAC252B),
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            onTap: () async {
              var incrementedQuantity =
                  widget.shoppingCartItem.getQuantity() + 1;

              widget.shoppingCartItem.setQuantity(incrementedQuantity);
              await updateCartItem(widget.shoppingCartItem);
              // setState(() {});

              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ShoppingCartScreen()));
            },
          ),
        ],
      ),
      SizedBox(height: 15),
      // ElevatedButton(
      //   style: ElevatedButton.styleFrom(
      //     primary: Color(0xFFAC252B),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(15.0),
      //     ),
      //   ),
      //   child: Text(
      //     translate("label_remove_cart_item"),
      //     style: Theme.of(context).textTheme.button!.copyWith(
      //           color: Colors.white,
      //         ),
      //   ),
      //   onPressed: () async {
      //     await removeCartItem(widget.shoppingCartItem);

      //     Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //             builder: (BuildContext context) => ShoppingCartScreen()));
      //   },
      // ),
    ]);
  }
}

updateCartItem(ShoppingCartItem shoppingCartItem) async {
  ShoppingCartItemRepository shoppingCartItemRepository =
      ShoppingCartItemRepositorySqfliteImpl();

  UpdateShoppingCartItemUsecase updateShoppingCartItemUsecase =
      UpdateShoppingCartItemUsecase(shoppingCartItemRepository);

  updateShoppingCartItemUsecase.updateItem(shoppingCartItem);
}

removeCartItem(ShoppingCartItem shoppingCartItem) async {
  ShoppingCartItemRepository shoppingCartItemRepository =
      ShoppingCartItemRepositorySqfliteImpl();

  RemoveShoppingCartItemUsecase removeShoppingCartItemUsecase =
      RemoveShoppingCartItemUsecase(shoppingCartItemRepository);

  removeShoppingCartItemUsecase.removeItem(shoppingCartItem);
}
