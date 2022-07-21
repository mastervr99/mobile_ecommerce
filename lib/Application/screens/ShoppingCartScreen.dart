import 'package:flutter/material.dart';
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
                  child: _CartList(),
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
    var itemNameStyle = Theme.of(context).textTheme.headline6;
    // This gets the current state of CartModel and also tells Flutter
    // to rebuild this widget when CartModel notifies listeners (in other words,
    // when it changes).
    var shoppingCart = context.watch<ShoppingCart>();
    var listShopppingCartItems = shoppingCart.getAllCartItems();
    return ListView.builder(
      itemCount: listShopppingCartItems.length,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.done),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () {
            // cart.remove(cart.items[index]);
          },
        ),
        title: Text(
          listShopppingCartItems[index].getTitle(),
          style: itemNameStyle,
        ),
      ),
    );
  }
}

// Widget emptyShoppingCart(BuildContext context) {
//   return Column(
//     children: <Widget>[
//       SizedBox(
//         height: 70,
//         child: Container(
//           color: Color(0xFFFFFFFF),
//         ),
//       ),
//       Container(
//         width: double.infinity,
//         height: 250,
//         child: Image.asset(
//           "assets/images/empty_shopping_cart.png",
//           height: 250,
//           width: double.infinity,
//         ),
//       ),
//       SizedBox(
//         height: 40,
//         child: Container(
//           color: Color(0xFFFFFFFF),
//         ),
//       ),
//       Container(
//         width: double.infinity,
//         child: Text(
//           "You haven't anything to cart",
//           style: TextStyle(
//             color: Color(0xFF67778E),
//             fontFamily: 'Roboto-Light.ttf',
//             fontSize: 20,
//             fontStyle: FontStyle.normal,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       )
//     ],
//   );
// }
