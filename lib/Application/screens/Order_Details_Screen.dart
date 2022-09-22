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
      body: FutureBuilder(
        future: get_order_items(widget.order),
        builder: (context, AsyncSnapshot snapshot) {
          var order_items = snapshot.data;

          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: translate("label_order") + ": ",
                            style: _theme.textTheme.headline5,
                          ),
                          TextSpan(
                            text: widget.order.get_order_reference(),
                            style: _theme.textTheme.headline5!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: translate("label_order_date") +
                                ": " +
                                widget.order.get_order_date(),
                            style: _theme.textTheme.headline5,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: translate("label_tracking_number") + ': TBD',
                            style: _theme.textTheme.headline5!,
                          ),
                          TextSpan(
                            // text: state.orderData.trackingNumber,
                            style: _theme.textTheme.headline5,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          order_items.length.toString(),
                          style: _theme.textTheme.headline5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            translate("label_items"),
                            style: _theme.textTheme.headline5,
                          ),
                        ),
                      ],
                    ),
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
                        translate("label_shipping_address") + ':',
                        widget.order.get_order_delivery_address(),
                        _theme,
                        width),
                    SizedBox(
                      height: 15,
                    ),
                    buildSummaryLine(translate("label_payment_method") + ':',
                        widget.order.get_order_payment_method(), _theme, width),
                    SizedBox(
                      height: 15,
                    ),
                    buildSummaryLine(
                        translate("label_total_amount") + ':',
                        '\€' + widget.order.get_order_price().toString(),
                        _theme,
                        width),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Circular_Progress_Widget();
          }
        },
      ),
    );
  }

  _build_order_items(order_items) {
    return <Widget>[
      for (Order_Item item in order_items)
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(20.0),
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          height: 180,
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
                        if (snapshot.hasData) {
                          return RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "${item.getTitle()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () async {
                                      // await get_product_from_order_item(item.getSku()).then();
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                              secondaryAnimation) {
                                            return Product_Detail_Screen(
                                                product: snapshot.data);
                                          },
                                          transitionDuration:
                                              Duration(milliseconds: 200),
                                        ),
                                      );
                                    }),
                            ]),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Circular_Progress_Widget();
                        }
                      },
                    ),
                    Text(
                      translate("label_price") +
                          " : ${item.getPrice()}" +
                          translate("label_currency"),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      translate("label_quantity") + " : ${item.get_quantity()}",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
            ],
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

  buildSummaryLine(String label, String text, ThemeData _theme, double width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: _theme.textTheme.headline5!,
          ),
        ),
        Container(
          width: width / 2,
          child: Text(
            text,
            style: _theme.textTheme.headline6,
          ),
        )
      ],
    );
  }
}
