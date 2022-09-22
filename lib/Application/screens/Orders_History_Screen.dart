import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Appbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Bottom_Navbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Circular_Progress_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Drawer_Widget.dart';
import 'package:mobile_ecommerce/Application/screens/Order_Details_Screen.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/order_repository.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/connected_user_repository_sqflite_impl.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/order_repository_sqflite_impl.dart';

class Orders_History_Screen extends StatefulWidget {
  @override
  _Orders_History_Screen_State createState() => _Orders_History_Screen_State();
}

class _Orders_History_Screen_State extends State<Orders_History_Screen> {
  final List<Widget> tabs = <Widget>[
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Tab(text: translate("label_processing_order")),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Tab(text: translate("label_delivered_order")),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Tab(text: translate("label_cancelled_order")),
    ),
  ];

  get_alll_user_order(BuildContext context) async {
    ConnectedUserRepository connectedUserRepository =
        ConnectedUserRepositorySqfliteImpl();

    var connected_user = await connectedUserRepository.retrieveConnectedUser();

    Order_Repository order_repository = Order_Repository_Sqflite_Impl();

    var orders =
        await order_repository.retrieve_all_user_orders(await connected_user);

    return await orders;
  }

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: Appbar_Widget(context),
      endDrawer: Drawer_Widget(),
      bottomNavigationBar: Bottom_Navbar_Widget(),
      body: SafeArea(
        child: DefaultTabController(
          length: tabs.length,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(bottom: 15)),
                      TabBar(
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.white,
                        labelPadding: EdgeInsets.symmetric(horizontal: 1),
                        unselectedLabelColor: Colors.black,
                        indicator: BubbleTabIndicator(
                          indicatorHeight: 32,
                          indicatorColor: Colors.black,
                          tabBarIndicatorSize: TabBarIndicatorSize.tab,
                        ),
                        tabs: tabs,
                        unselectedLabelStyle: _theme.textTheme.headline6,
                        labelStyle: _theme.textTheme.headline6!
                            .copyWith(color: Colors.white),
                      ),
                    ]),
              ),
              Padding(padding: EdgeInsets.only(bottom: 15)),
              Expanded(
                child: FutureBuilder(
                  future: get_alll_user_order(context),
                  builder: (context, AsyncSnapshot snapshot) {
                    var orders = snapshot.data;

                    if (snapshot.hasData) {
                      var processing_orders = [];
                      var delivered_orders = [];
                      var cancelled_orders = [];

                      orders.forEach(
                        (order) {
                          if (order.get_order_state() == "processing") {
                            print(order);
                          }

                          switch (order.get_order_state()) {
                            case "processing":
                              {
                                processing_orders.add(order);
                              }
                              break;

                            case "delivered":
                              {
                                delivered_orders.add(order);
                              }
                              break;

                            default:
                              {
                                cancelled_orders.add(order);
                              }
                              break;
                          }
                        },
                      );

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TabBarView(
                          children: <Widget>[
                            buildOrdersList(context, processing_orders),
                            buildOrdersList(context, delivered_orders),
                            buildOrdersList(context, cancelled_orders),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Circular_Progress_Widget();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

buildOrdersList(BuildContext context, List orders) {
  var _theme = Theme.of(context);

  return ListView.builder(
    itemCount: orders.length,
    itemBuilder: (context, index) {
      if (orders[index] != null && orders.isNotEmpty) {
        return Container(
          padding: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(translate("label_order_date") + ' : ',
                          style: _theme.textTheme.headline6!),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          orders[index]!.get_order_date(),
                          style: _theme.textTheme.subtitle1,
                        ),
                      ),
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
                              text: translate("label_order") + ' :  ',
                              style: _theme.textTheme.subtitle1!
                                  .copyWith(fontWeight: FontWeight.normal),
                            ),
                            TextSpan(
                              text: orders[index].get_order_reference(),
                              style: _theme.textTheme.subtitle1!
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Text(translate("label_total_amount") + ' : ',
                          style: _theme.textTheme.subtitle1!),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          '\€' + orders[index].get_order_price().toString(),
                          style: _theme.textTheme.subtitle1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                              left: 24, right: 24, top: 10, bottom: 10),
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.black, width: 2)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Order_Details_Screen(order: orders[index]),
                            ),
                          );
                        },
                        child: Text(
                          translate("label_details"),
                          style: _theme.textTheme.headline6,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      } else {
        return SizedBox.shrink();
      }
    },
  );
}
