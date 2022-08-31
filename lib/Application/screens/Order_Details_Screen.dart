import 'package:flutter/material.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Appbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Bottom_Navbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Drawer_Widget.dart';
import 'package:mobile_ecommerce/Domain/Entity/order.dart';

class Order_Details_Screen extends StatefulWidget {
  Order order;

  Order_Details_Screen({Key? key, required this.order}) : super(key: key);

  @override
  _Order_Details_Screen_State createState() => _Order_Details_Screen_State();
}

class _Order_Details_Screen_State extends State<Order_Details_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_Widget(context),
      endDrawer: Drawer_Widget(),
      bottomNavigationBar: Bottom_Navbar_Widget(),
      body: Column(
        children: [Text(widget.order.get_order_reference())],
      ),
    );
  }
}
