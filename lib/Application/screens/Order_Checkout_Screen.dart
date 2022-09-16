import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Appbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Circular_Progress_Widget.dart';
import 'package:mobile_ecommerce/Application/screens/Orders_History_Screen.dart';
import 'package:mobile_ecommerce/Application/usecases/make_an_order_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/order.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/order_item_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/order_repository.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/connected_user_repository_sqflite_impl.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/order_item_repository_sqflite_impl.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/order_repository_sqflite_impl.dart';
import 'package:mobile_ecommerce/Infrastructure/stripe_payment_controller.dart';
import 'package:mobile_ecommerce/Domain/Entity/shopping_cart.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/shopping_cart_item_repository.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/shopping_cart_item_repository_sqflite_impl.dart';
import 'package:provider/provider.dart';

class Order_Checkout_Screen extends StatefulWidget {
  @override
  _Order_Checkout_Screen_State createState() => _Order_Checkout_Screen_State();
}

class _Order_Checkout_Screen_State extends State<Order_Checkout_Screen> {
  int? deliveryMethodRadioButtonChoiceValue = -1;
  int? paymentMethodRadioButtonChoiceValue = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar_Widget(context),
      body: LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Select Delivery method',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  // height: 264.0,
                  margin: EdgeInsets.all(10.0),
                  // child: Card(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        // _verticalD(),
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Text("Home delivery",
                                            maxLines: 10,
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black)),
                                        Radio<int>(
                                          value: 1,
                                          groupValue:
                                              deliveryMethodRadioButtonChoiceValue,
                                          onChanged: (value) {
                                            setState(() {
                                              deliveryMethodRadioButtonChoiceValue =
                                                  value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        DeliveryAdressSelection(),
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Store Pick Up",
                                  maxLines: 10,
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black)),
                              Radio<int>(
                                  value: 1,
                                  groupValue:
                                      deliveryMethodRadioButtonChoiceValue,
                                  onChanged: (value) {
                                    setState(() {
                                      deliveryMethodRadioButtonChoiceValue =
                                          value;
                                    });
                                  }),
                            ],
                          ),
                        ),
                        // Divider(),
                      ],
                    ),
                    // ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Select Payment method',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // _verticalDivider(),
                Container(
                  // height: 264.0,
                  margin: EdgeInsets.all(10.0),
                  // child: Card(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        // _verticalD(),
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Credit / Debit / ATM Card",
                                      maxLines: 10,
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.black)),
                                  Radio<int>(
                                      value: 1,
                                      groupValue:
                                          paymentMethodRadioButtonChoiceValue,
                                      onChanged: (value) {
                                        setState(() {
                                          paymentMethodRadioButtonChoiceValue =
                                              value;
                                        });
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        // _verticalD(),
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Cash on Delivery",
                                  maxLines: 10,
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black)),
                              Radio<int>(
                                  value: 2,
                                  groupValue:
                                      paymentMethodRadioButtonChoiceValue,
                                  onChanged: (value) {
                                    setState(() {
                                      paymentMethodRadioButtonChoiceValue =
                                          value;
                                    });
                                  }),
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: OrderCheckoutScreenBottomBar(),
    );
    //       }
    //     },
    //   );
    // });
  }
}

getShoppingCartTotalQuantity(BuildContext context) async {
  ShoppingCartItemRepository shoppingCartItemRepository =
      ShoppingCartItemRepositorySqfliteImpl();

  // var shoppingCart = context.watch<ShoppingCart>();
  var shoppingCart = ShoppingCart();

  await shoppingCart.setItemRepository(shoppingCartItemRepository);

  var shopping_cart_total_quantity = await shoppingCart.getItemsTotalQuantity();

  return await shopping_cart_total_quantity;
}

getShoppingCartTotalPrice(BuildContext context) async {
  ShoppingCartItemRepository shoppingCartItemRepository =
      ShoppingCartItemRepositorySqfliteImpl();

  // var shoppingCart = context.watch<ShoppingCart>();
  var shoppingCart = ShoppingCart();

  await shoppingCart.setItemRepository(shoppingCartItemRepository);

  var shopping_cart_total_price = await shoppingCart.getCartTotalPrice();

  return await shopping_cart_total_price;
}

class OrderCheckoutScreenBottomBar extends StatefulWidget {
  @override
  _OrderCheckoutScreenBottomBarState createState() =>
      _OrderCheckoutScreenBottomBarState();
}

register_order(BuildContext context, Order order) async {
  ShoppingCartItemRepository shoppingCartItemRepository =
      ShoppingCartItemRepositorySqfliteImpl();

  Make_An_Order_Usecase make_an_order_usecase =
      Make_An_Order_Usecase(shoppingCartItemRepository);

  ConnectedUserRepository connectedUserRepository =
      ConnectedUserRepositorySqfliteImpl();

  Order_Repository order_repository = Order_Repository_Sqflite_Impl();

  await make_an_order_usecase.register_user_order(
      connectedUserRepository, order, order_repository);

  Order_Item_Repository order_item_repository =
      Order_Item_Repostitory_Sqflite_Impl();

  await make_an_order_usecase.register_order_items(
      order_item_repository, order);
  return AlertDialog(
    // Retrieve the text the that user has entered by using the
    // TextEditingController.
    content: Text(
      translate('PAYMENT VALIDATED'),
      textAlign: TextAlign.center,
    ),
  );
}

class _OrderCheckoutScreenBottomBarState
    extends State<OrderCheckoutScreenBottomBar> {
  @override
  Widget build(BuildContext context) {
    final Stripe_Payment_Controller controller =
        Get.put(Stripe_Payment_Controller());
    // return Consumer<ShoppingCart>(builder: (context, settings, child) {
    return FutureBuilder(
      future: getShoppingCartTotalPrice(context),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            height: 48.0,
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Subtotal :',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                FutureBuilder(
                  future: getShoppingCartTotalQuantity(context),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data.toString() + ' items',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Circular_Progress_Widget();
                    }
                  },
                ),
                Text(
                  snapshot.data.toString() + '€',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xFFAC252B)),
                  child: Text(translate('PAY')),
                  onPressed: (() async {
                    await controller.makePayment(
                        context: context,
                        amount: snapshot.data.toString(),
                        currency: 'USD');
                    bool is_payment_valid =
                        await controller.check_if_payment_valid();
                    if (is_payment_valid) {
                      Order order = Order();
                      await register_order(context, order);

                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return Orders_History_Screen();
                          },
                          transitionDuration: Duration(milliseconds: 200),
                        ),
                      );
                    }
                  }),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Circular_Progress_Widget();
        }
      },
    );
    // });
  }
}

class DeliveryAdressSelection extends StatefulWidget {
  @override
  _DeliveryAdressSelectionState createState() =>
      _DeliveryAdressSelectionState();
}

class _DeliveryAdressSelectionState extends State<DeliveryAdressSelection> {
  bool? value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 165.0,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              height: 165.0,
              width: 56.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child:
                          IconButton(icon: Icon(Icons.add), onPressed: null)),
                ],
              ),
            ),
            Container(
              height: 165.0,
              width: 200.0,
              margin: EdgeInsets.all(7.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Naomi A. Schultz',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            // _verticalDivider(),
                            Text(
                              '2585 Columbia Boulevard',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 13.0,
                                  letterSpacing: 0.5),
                            ),
                            // _verticalDivider(),
                            Text(
                              'Salisbury',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 13.0,
                                  letterSpacing: 0.5),
                            ),
                            // _verticalDivider(),
                            Text(
                              'MD 21801',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 13.0,
                                  letterSpacing: 0.5),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 00.0,
                                  top: 05.0,
                                  right: 0.0,
                                  bottom: 5.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Delivery Address',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black26,
                                    ),
                                  ),
                                  // _verticalD(),
                                  Checkbox(
                                    value: this.value,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        this.value = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 130.0,
              width: 200.0,
              margin: EdgeInsets.all(7.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Lisa J. Cunningham',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            // _verticalDivider(),
                            Text(
                              '49 Bagwell Avenue',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 13.0,
                                  letterSpacing: 0.5),
                            ),
                            // _verticalDivider(),
                            Text(
                              'Ocala',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 13.0,
                                  letterSpacing: 0.5),
                            ),
                            // _verticalDivider(),
                            Text(
                              ' FL 34471',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 13.0,
                                  letterSpacing: 0.5),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 00.0,
                                  top: 05.0,
                                  right: 0.0,
                                  bottom: 5.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Delivery Address',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  // _verticalD(),
                                  Checkbox(
                                    value: this.value,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        this.value = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 130.0,
              width: 200.0,
              margin: EdgeInsets.all(7.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Elizabeth J. Schmidt',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            // _verticalDivider(),
                            Text(
                              '3674 Oakway Lane',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 13.0,
                                  letterSpacing: 0.5),
                            ),
                            // _verticalDivider(),
                            Text(
                              'Long Beach',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 13.0,
                                  letterSpacing: 0.5),
                            ),
                            // _verticalDivider(),
                            Text(
                              ' CA 90802',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 13.0,
                                  letterSpacing: 0.5),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 00.0,
                                  top: 05.0,
                                  right: 0.0,
                                  bottom: 5.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Delivery Address',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  // _verticalD(),
                                  Checkbox(
                                    value: this.value,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        this.value = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
    // _verticalDivider(),
  }
}
