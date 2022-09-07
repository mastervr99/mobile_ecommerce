import 'package:flutter/material.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Circular_Progress_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Products_Slider_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Search_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Promo_Slider_Widget.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/product_repository.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/product_repository_sqflite_impl.dart';

/** 
import 'package:mobile_ecommerce/components/BrandHomePage.dart';
import 'package:mobile_ecommerce/components/CategorySlider.dart';
import 'package:mobile_ecommerce/common_widget/PopularMenu.dart';
import 'package:mobile_ecommerce/common_widget/TopPromoSlider.dart';
import 'package:mobile_ecommerce/components/ShopHomePage.dart';
*/

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

class _Home_Screen_State extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Search_Widget(),
          Promo_Slider_Widget(),
          //PopularMenu(),
          FutureBuilder(
            future: get_trending_products(),
            builder: (context, AsyncSnapshot snapshot) {
              var products = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Circular_Progress_Widget();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else
                    return Products_Slider_Widget(products: products);
              }
            },
          ),
          SizedBox(
            height: 10,
            child: Container(
              color: Color(0xFFf5f6f7),
            ),
          ),
          PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: 'Categories',
                ),
                Tab(
                  text: 'Brands',
                ),
                Tab(
                  text: 'Shops',
                )
              ], // list of tabs
            ),
          ),
          SizedBox(
            height: 10,
            child: Container(
              color: Color(0xFFf5f6f7),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                Container(
                  color: Colors.white24,
                  //child: CategoryPage(slug: 'categories/'),
                ),
                Container(
                  color: Colors.white24,
                  //child: BrandHomePage(slug: 'brands/?limit=20&page=1'),
                ),
                Container(
                  color: Colors.white24,
                  //child: ShopHomePage(
                  //  slug: 'custom/shops/?page=1&limit=15',
                  //),
                ) // class name
              ],
            ),
          ),
        ],
      ),
    );
  }
}
