import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Appbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Bottom_Navbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Circular_Progress_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Drawer_Widget.dart';
import 'package:mobile_ecommerce/Application/screens/Product_Detail_Screen.dart';
import 'package:mobile_ecommerce/Domain/Entity/order.dart';
import 'package:mobile_ecommerce/Domain/Entity/order_item.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/order_item_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/product_repository.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/order_item_repository_sqflite_impl.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/product_repository_sqflite_impl.dart';

class Order_Details_Screen extends StatefulWidget {
  Order order;

  Order_Details_Screen({Key? key, required this.order}) : super(key: key);

  @override
  _Order_Details_Screen_State createState() => _Order_Details_Screen_State();
}

get_order_items(Order order) async {
  Order_Item_Repository order_item_repository =
      Order_Item_Repostitory_Sqflite_Impl();

  var order_items = await order_item_repository
      .retrieve_items_by_order_reference(order.get_order_reference());

  return await order_items;
}

class _Order_Details_Screen_State extends State<Order_Details_Screen> {
  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: Appbar_Widget(context),
      endDrawer: Drawer_Widget(),
      bottomNavigationBar: Bottom_Navbar_Widget(),
      // body: Column(
      //   children: [Text(widget.order.get_order_reference())],
      // ),

      body: FutureBuilder(
        future: get_order_items(widget.order),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Circular_Progress_Widget();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Padding(
                  padding: EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RichText(
                                text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Order: ',
                                style: _theme.textTheme.headline5,
                              ),
                              TextSpan(
                                // text: '#' +
                                //     state.orderData.orderNumber.toString(),
                                text: 'test',
                                style: _theme.textTheme.headline5!
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                            ])),
                            Text(
                                // DateFormat('yyyy-MM-dd')
                                //     .format(state.orderData.orderDate),
                                'test',
                                style: _theme.textTheme.headline3!
                                    .copyWith(color: Color(0xFF9B9B9B)))
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Tacking Number: ',
                                    style: _theme.textTheme.headline5!.copyWith(
                                        color: _theme.primaryColorLight),
                                  ),
                                  TextSpan(
                                    // text: state.orderData.trackingNumber,
                                    style: _theme.textTheme.headline5,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              // widget.order.get_order_state(),
                              'DELIVREEEE',
                              style: _theme.textTheme.headline5!
                                  .copyWith(color: Colors.green),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: <Widget>[
                        //     Row(
                        //       children: <Widget>[
                        //         Text(
                        //           // state.orderData.totalQuantity.toString(),
                        //           'test',
                        //           style: _theme.textTheme.headline5,
                        //         ),
                        //         Padding(
                        //           padding: const EdgeInsets.only(left: 4),
                        //           child: Text(
                        //             'items',
                        //             style: _theme.textTheme.headline5,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: _build_order_items(snapshot.data),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        buildSummaryLine(
                            'Shipping Address:',
                            // snapshot.data.orderData.shippingAddress.toString(),
                            'test',
                            _theme,
                            width),
                        SizedBox(
                          height: 15,
                        ),
                        buildSummaryLine(
                            'Payment Methods:',
                            // snapshot.data.orderData.paymentMethod,
                            'test',
                            _theme,
                            width),
                        SizedBox(
                          height: 15,
                        ),
                        buildSummaryLine(
                            'Discount:',
                            // snapshot.data.orderData.promo.toString(),
                            'test',
                            _theme,
                            width),
                        SizedBox(
                          height: 15,
                        ),
                        buildSummaryLine(
                            'Total Amount:',
                            '\$' +
                                // snapshot.data.orderData.totalPrice
                                // .toStringAsFixed(0),
                                'test',
                            _theme,
                            width),
                        SizedBox(
                          height: 15,
                        ),
                        // Row(children: <Widget>[
                        // OpenFlutterButton(
                        //   backgroundColor: Colors.white,
                        //   borderColor: _theme.primaryColor,
                        //   textColor: _theme.primaryColor,
                        //   height: 36,
                        //   width: (width - 15 * 3) / 2,
                        //   title: 'Reorder',
                        //   onPressed: (() => {
                        //         //TODO: reorder process
                        //       }),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 15),
                        // ),
                        // OpenFlutterButton(
                        //   height: 36,
                        //   width: (width - 15 * 3) / 2,
                        //   title: 'Leave Feedback',
                        //   onPressed: (() => {
                        //         //TODO: leave feedback
                        //       }),
                        // )
                        // ])
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }

  _build_order_items(order_items) {
    return <Widget>[
      for (Order_Item item in order_items)
        Padding(
          padding: const EdgeInsets.all(32),
          child: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                    ),
                    child: Image.network(
                      "${item.getImageUrl()}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder(
                        future: get_product_from_order_item(item),
                        builder: (context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return Circular_Progress_Widget();
                            default:
                              if (snapshot.hasError)
                                return Text('Error: ${snapshot.error}');
                              else
                                return RichText(
                                  text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                        text: "${item.getTitle()}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                        recognizer: new TapGestureRecognizer()
                                          ..onTap = () async {
                                            // await get_product_from_order_item(item.getSku()).then();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Product_Detail_Screen(
                                                        product: snapshot.data),
                                              ),
                                            );
                                          }),
                                  ]),
                                );
                          }
                        },
                      ),
                      Text(
                        "Price : ${item.getPrice()}" +
                            translate("label_currency"),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        "Quantity : ${item.get_quantity()}",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    ];
  }

  get_product_from_order_item(Order_Item order_item) async {
    ProductRepository productRepository = ProductRepostitorySqfliteImpl();

    var product =
        await productRepository.retrieve_product_with_sku(order_item.getSku());

    return await product;
  }

  Row buildSummaryLine(
      String label, String text, ThemeData _theme, double width) {
    print(label + ' ' + text);
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: _theme.textTheme.headline5!
                .copyWith(color: _theme.primaryColorLight),
          ),
          Container(
            width: width / 2,
            child: Text(
              text,
              style: _theme.textTheme.headline6,
            ),
          )
        ]);
  }
}
