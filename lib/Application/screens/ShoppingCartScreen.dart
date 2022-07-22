import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/common_widgets/AppBarWidget.dart';
import 'package:mobile_ecommerce/Domain/Entity/shopping_cart.dart';
import 'package:provider/provider.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    var shoppingCart = context.watch<ShoppingCart>();
    var shopppingCartItems = shoppingCart.getAllCartItems();

    return Consumer<ShoppingCart>(builder: (context, settings, child) {
      return Scaffold(
        appBar: appBarWidget(context),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: shopppingCartItems.isEmpty
                      ? _emptyShoppingCart(context)
                      : _CartList(),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var shoppingCart = context.watch<ShoppingCart>();
    var shopppingCartItems = shoppingCart.getAllCartItems();

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
                    Text(translate("label_currency") + "899.01",
                        style: Theme.of(context).textTheme.headline6),
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
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    onPressed: () {},
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
              itemCount: shopppingCartItems.length,
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
                            "${shopppingCartItems[index].getImageUrl()}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${shopppingCartItems[index].getTitle()}",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              "${shopppingCartItems[index].getPrice()}" +
                                  translate("label_currency"),
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            SizedBox(height: 15),
                            MyCounter(),
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
}

class MyCounter extends StatefulWidget {
  const MyCounter({
    Key? key,
  }) : super(key: key);

  @override
  _MyCounterState createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  int _currentAmount = 0;
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
            onTap: () {
              setState(() {
                _currentAmount -= 1;
              });
            },
          ),
          SizedBox(width: 15),
          Text(
            "$_currentAmount",
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
            onTap: () {
              setState(() {
                _currentAmount += 1;
              });
            },
          ),
        ],
      ),
      SizedBox(height: 15),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFAC252B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Text(
          translate("label_remove_cart_item"),
          style: Theme.of(context).textTheme.button!.copyWith(
                color: Colors.white,
              ),
        ),
        onPressed: () {},
      ),
    ]);
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
          style: TextStyle(
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
