import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Appbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Circular_Progress_Widget.dart';
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
    // return Consumer<ShoppingCart>(builder: (context, settings, child) {
    //   return FutureBuilder(
    //     future: getShoppingCartTotalQuantity(context),
    //     builder: (context, AsyncSnapshot snapshot) {
    //       switch (snapshot.connectionState) {
    //         case ConnectionState.none:
    //         case ConnectionState.waiting:
    //           return CircularProgress();
    //         default:
    //           if (snapshot.hasError)
    //             return Text('Error: ${snapshot.error}');
    //           else
    // return createDetailView(context, snapshot);

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   iconTheme: IconThemeData(color: Colors.grey),
      //   actions: <Widget>[
      //     // IconButton(
      //     //   icon: Image.asset('assets/icons/denied_wallet.png'),
      //     //   onPressed: () => Navigator.of(context)
      //     //       .push(MaterialPageRoute(builder: (_) => UnpaidPage())),
      //     // )
      //   ],
      //   title: Text(
      //     'Checkout',
      //     style: TextStyle(
      //         color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 18.0),
      //   ),
      // ),
      appBar: Appbar_Widget(context),
      body: LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // SizedBox(
                //   height: 300,
                //   child: Scrollbar(
                //     child: ListView.builder(
                //       itemBuilder: (_, index) => ShopItemList(
                //         products[index],
                //         onRemove: () {
                //           setState(() {
                //             products.remove(products[index]);
                //           });
                //         },
                //       ),
                //       itemCount: products.length,
                //     ),
                //   ),
                // ),
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
                              //**************** TO REMOVE **************** */
                              // CardFormField(
                              //     controller: CardFormEditController()),
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

                // SizedBox(
                //   height: 250,
                //   child: Swiper(
                //     itemCount: 2,
                //     itemBuilder: (_, index) {
                //       return CreditCard();
                //     },
                //     scale: 0.8,
                //     controller: swiperController,
                //     viewportFraction: 0.6,
                //     loop: false,
                //     fade: 0.7,
                //   ),
                // ),
                // SizedBox(height: 24),
                // Center(
                //     child: Padding(
                //   padding: EdgeInsets.only(
                //       bottom:
                //           MediaQuery.of(context).padding.bottom == 0
                //               ? 20
                //               : MediaQuery.of(context)
                //                   .padding
                //                   .bottom),
                //   child: ElevatedButton,
                // ))
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

  var shoppingCart = context.watch<ShoppingCart>();

  await shoppingCart.setItemRepository(shoppingCartItemRepository);

  return await shoppingCart.getItemsTotalQuantity();
}

class OrderCheckoutScreenBottomBar extends StatefulWidget {
  @override
  _OrderCheckoutScreenBottomBarState createState() =>
      _OrderCheckoutScreenBottomBarState();
}

class _OrderCheckoutScreenBottomBarState
    extends State<OrderCheckoutScreenBottomBar> {
  @override
  Widget build(BuildContext context) {
    final StripePaymentController controller =
        Get.put(StripePaymentController());
    return Consumer<ShoppingCart>(builder: (context, settings, child) {
      return FutureBuilder(
          future: getShoppingCartTotalQuantity(context),
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Circular_Progress_Widget();
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    height: 48.0,
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Subtotal',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Text(
                          snapshot.data.toString() + ' items',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFFAC252B)),
                          child: Text(translate('PAY')),
                          onPressed: (() async {
                            await controller.makePayment(
                                context: context, amount: '5', currency: 'USD');
                          }),
                        ),
                        // CardField(
                        //   onCardChanged: (card) {
                        //     print(card);
                        //   },
                        // ),
                        // TextButton(
                        //   onPressed: () async {
                        //     // create payment method
                        //     // final paymentMethod = await Stripe.instance
                        //     //     .createPaymentMethod(
                        //     //         PaymentMethodParams.card());
                        //   },
                        //   child: Text('pay'),
                        // ),
                      ],
                    ),
                  );
            }
          });
    });
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
              // child: Card(
              //   elevation: 3.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child:
                          IconButton(icon: Icon(Icons.add), onPressed: null)),
                ],
              ),
              // ),
            ),
            Container(
              height: 165.0,
              width: 200.0,
              margin: EdgeInsets.all(7.0),
              // child: Card(
              //   elevation: 3.0,
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
              // ),
            ),
            Container(
              height: 130.0,
              width: 200.0,
              margin: EdgeInsets.all(7.0),
              // child: Card(
              //   elevation: 3.0,
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
              // ),
            ),
            Container(
              height: 130.0,
              width: 200.0,
              margin: EdgeInsets.all(7.0),
              // child: Card(
              //   elevation: 3.0,
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
              // ),
            ),
          ],
        ));
    // _verticalDivider(),
  }
}
