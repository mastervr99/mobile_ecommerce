import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Appbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Bottom_Navbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Category_Slider_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Circular_Progress_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Drawer_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Products_Slider_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Search_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Promo_Slider_Widget.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/product_repository.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/product_repository_sqflite_impl.dart';

class Home_Screen extends StatefulWidget {
  @override
  _Home_Screen_State createState() => _Home_Screen_State();
}

get_trending_products() async {
  ProductRepository productRepository = ProductRepostitorySqfliteImpl();

  var trending_products =
      await productRepository.retrieveProductsByTitle('gini');

  return await trending_products;
}

get_girls_products() async {
  ProductRepository productRepository = ProductRepostitorySqfliteImpl();

  var trending_products =
      await productRepository.retrieveProductsByTitle('girl');

  return await trending_products;
}

class _Home_Screen_State extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_Widget(context),
      endDrawer: Drawer_Widget(),
      bottomNavigationBar: Bottom_Navbar_Widget(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white70,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  Search_Widget(),
                  Promo_Slider_Widget(),
                  SizedBox(
                    height: 15,
                    child: Container(
                      color: Color(0xFFf5f6f7),
                    ),
                  ),
                  FutureBuilder(
                    future: get_trending_products(),
                    builder: (context, AsyncSnapshot snapshot) {
                      var products = snapshot.data;

                      if (snapshot.hasData) {
                        return Products_Slider_Widget(
                            products: products,
                            title: translate("label_trending_products") +
                                ' : Gini & Jony');
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Circular_Progress_Widget();
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                    child: Container(
                      color: Color(0xFFf5f6f7),
                    ),
                  ),
                  Category_Slider_Widget(),
                  SizedBox(
                    height: 15,
                    child: Container(
                      color: Color(0xFFf5f6f7),
                    ),
                  ),
                  FutureBuilder(
                    future: get_girls_products(),
                    builder: (context, AsyncSnapshot snapshot) {
                      var products = snapshot.data;

                      if (snapshot.hasData) {
                        return Products_Slider_Widget(
                            products: products,
                            title: translate("label_girls_selection"));
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Circular_Progress_Widget();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
