import 'package:flutter/material.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Appbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Bottom_Navbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Circular_Progress_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Drawer_Widget.dart';
import 'package:mobile_ecommerce/Application/usecases/add_product_to_shopping_cart_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/shopping_cart_item_repository.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/shopping_cart_item_repository_sqflite_impl.dart';

class Product_Detail_Screen extends StatefulWidget {
  Product product;

  Product_Detail_Screen({Key? key, required this.product}) : super(key: key);

  @override
  _Product_Detail_Screen_State createState() => _Product_Detail_Screen_State();
}

class _Product_Detail_Screen_State extends State<Product_Detail_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfafafa),
      appBar: Appbar_Widget(context),
      endDrawer: Drawer_Widget(),
      bottomNavigationBar: Bottom_Navbar_Widget(),
      body: FutureBuilder(
        future: getProduct(widget.product),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Circular_Progress_Widget();
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                return createDetailView(context, snapshot);
          }
        },
      ),
    );
  }
}

Widget createDetailView(BuildContext context, AsyncSnapshot snapshot) {
  var values = snapshot.data;
  return DetailScreen(
    product: values,
  );
}

class DetailScreen extends StatefulWidget {
  Product product;

  DetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image.network(
            widget.product.getImageUrl(),
            fit: BoxFit.fill,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!.toInt()
                      : null,
                ),
              );
            },
          ),
          Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            color: Color(0xFFFFFFFF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("${widget.product.getTitle()}",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF4c4c4c))),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            color: Color(0xFFFFFFFF),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Price".toUpperCase(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF565656))),
                Text(
                    "€ ${(widget.product.getPrice() != null) ? widget.product.getPrice() : "Unavailable"}"
                        .toUpperCase(),
                    style: TextStyle(
                        color: (widget.product.getPrice() != null)
                            ? Color(0xFFf67426)
                            : Color(0xFF0dc2cd),
                        fontFamily: 'Roboto-Light.ttf',
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            color: Color(0xFFFFFFFF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Description",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF565656))),
                SizedBox(
                  height: 15,
                ),
                Text("${widget.product.getDescription()}",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF4c4c4c))),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFAC252B),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
                side: BorderSide(color: Color(0xFFfef2f2)),
              ),
              minimumSize: Size(300, 50),
              textStyle: const TextStyle(
                color: Colors.white,
              ),
              elevation: 0,
            ),
            onPressed: () async {
              ShoppingCartItemRepository shoppingCartItemRepository =
                  ShoppingCartItemRepositorySqfliteImpl();

              Add_Product_To_Shopping_Cart_Usecase
                  add_product_to_shopping_cart_usecase =
                  Add_Product_To_Shopping_Cart_Usecase(
                      shoppingCartItemRepository);

              await add_product_to_shopping_cart_usecase
                  .addCartItem(widget.product);

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(
                      'Product added to cart !',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              );
            },
            child: Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 15),
              child: Text(
                "Add to cart".toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<Product?> getProduct(Product product) async {
  return product;
}
