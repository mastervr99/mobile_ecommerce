import 'dart:convert';
import 'dart:math';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Circular_Progress_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Drawer_Widget.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Appbar_Widget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/Bottom_Navbar_Widget.dart';
import 'package:mobile_ecommerce/Application/components/Products_Grid_Tiles_Component.dart';
import 'package:mobile_ecommerce/Application/usecases/search_product_usecase.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/product_repository_sqflite_impl.dart';

class Products_Search_Screen extends StatefulWidget {
  var searchTerms;

  Products_Search_Screen({Key? key, this.searchTerms}) : super(key: key);

  @override
  _Products_Search_Screen_State createState() =>
      _Products_Search_Screen_State(searchTerms: searchTerms);
}

class _Products_Search_Screen_State extends State<Products_Search_Screen>
    with SingleTickerProviderStateMixin {
  String selectedPeriod = "";
  String selectedCategory = "";
  String selectedPrice = "";

  List<String> timeFilter = [
    'Brand',
    'New',
    'Latest',
    'Trending',
    'Discount',
  ];

  List<String> categoryFilter = [
    'Skull Candy',
    'Boat',
    'JBL',
    'Micromax',
    'Seg',
  ];

  List<String> priceFilter = [
    '\$50-200',
    '\$200-400',
    '\$400-800',
    '\$800-1000',
  ];

  var searchTerms;

  _Products_Search_Screen_State({this.searchTerms});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/search_background_image.jpg"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: Appbar_Widget(context),
        endDrawer: Drawer_Widget(),
        bottomNavigationBar: Bottom_Navbar_Widget(),
        body: Column(
          children: <Widget>[
            // **************** TO REMOVE **************** */
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //       textStyle: const TextStyle(fontSize: 20)),
            //   onPressed: () async {
            //     await createProductTable();
            //   },
            //   child: const Text('Enabled'),
            // ),
            // ******************************** */

            Card(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Theme(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            prefixIcon: Icon(Icons.search),
                            fillColor: Color(0xFFF2F4F5),
                            hintStyle: new TextStyle(color: Colors.grey[600]),
                            hintText: translate("label_search"),
                          ),
                          autofocus: false,
                          onSubmitted: (value) async {
                            setState(() {
                              searchTerms = value;
                            });
                          },
                        ),
                        data: Theme.of(context).copyWith(
                          primaryColor: Colors.grey[600],
                        ),
                      ),
                    ),
                    IconButton(
                        tooltip: 'Sort',
                        icon: const Icon(Icons.filter_list),
                        onPressed: () {
                          showModalBottomSheet(
                              // isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(25),
                                  topStart: Radius.circular(25),
                                ),
                              ),
                              builder: (BuildContext context) {
                                return _filters_modal();
                              });
                        }),
                  ],
                ),
              ),
            ),

            if (searchTerms != null && searchTerms.isNotEmpty)
              FutureBuilder(
                future: findProducts(searchTerms),
                builder: (context, AsyncSnapshot snapshot) {
                  List<dynamic>? productsList = snapshot.data;

                  if (snapshot.hasData) {
                    if (productsList!.isEmpty)
                      return Center(
                        child: Text(translate('label_product_search_failed')),
                      );
                    else
                      return Expanded(
                        child: GridView.count(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          padding: EdgeInsets.all(1.0),
                          childAspectRatio: 8.0 / 12.0,
                          children: List<Widget>.generate(productsList.length,
                              (index) {
                            return GridTile(
                                child: Products_Grid_Tiles_Component(
                              name: productsList[index]!.getTitle(),
                              imageUrl: productsList[index]!.getImageUrl(),
                              product: productsList[index]!,
                              price: productsList[index]!.getPrice().toString(),
                            ));
                          }),
                        ),
                      );
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
    );
  }

  Widget _filters_modal() {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                offset: Offset(0, -3),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), topLeft: Radius.circular(24)),
          color: Colors.white),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Filters',
                style: TextStyle(color: Colors.grey[300]),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 32.0, top: 16.0, bottom: 16.0),
              child: Text(
                'Sort By',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              itemBuilder: (_, index) => Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedPeriod = timeFilter[index];
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 20.0),
                        decoration: selectedPeriod == timeFilter[index]
                            ? BoxDecoration(
                                color: Color(0xffFDB846),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45)))
                            : BoxDecoration(),
                        child: Text(
                          timeFilter[index],
                          style: TextStyle(fontSize: 16.0),
                        ))),
              )),
              itemCount: timeFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              itemBuilder: (_, index) => Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedCategory = categoryFilter[index];
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 20.0),
                        decoration: selectedCategory == categoryFilter[index]
                            ? BoxDecoration(
                                color: Color(0xffFDB846),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45)))
                            : BoxDecoration(),
                        child: Text(
                          categoryFilter[index],
                          style: TextStyle(fontSize: 16.0),
                        ))),
              )),
              itemCount: categoryFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              itemBuilder: (_, index) => Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedPrice = priceFilter[index];
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 20.0),
                        decoration: selectedPrice == priceFilter[index]
                            ? BoxDecoration(
                                color: Color(0xffFDB846),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45)))
                            : BoxDecoration(),
                        child: Text(
                          priceFilter[index],
                          style: TextStyle(fontSize: 16.0),
                        ))),
              )),
              itemCount: priceFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}

findProducts(var value) async {
  ProductRepostitorySqfliteImpl productRepository =
      ProductRepostitorySqfliteImpl();

  Search_Product_Usecase search_product_usecase =
      Search_Product_Usecase(productRepository);

  var searchedProducts =
      await search_product_usecase.searchProductsByTitle(value);

  return await searchedProducts;
}

// **************** TO REMOVE **************** */
// createProductTable() async {
//   var productRepository = ProductRepostitorySqfliteImpl();

//   WidgetsFlutterBinding.ensureInitialized();

//   final _rawData =
//       await rootBundle.loadString("assets/csv_database/fashion.csv");

//   var encoded = utf8.encode(_rawData);
//   var decoded = utf8.decode(encoded);
//   var rowAsListValues =
//       const CsvToListConverter(fieldDelimiter: ',', eol: '\n').convert(decoded);
//   var parsedList = [];

//   for (var items in rowAsListValues) {
//     parsedList.add(items);
//   }

//   parsedList.removeAt(0);

//   for (int i = 0; i < parsedList.length; i++) {
//     parsedList[i].removeAt(0);
//     parsedList[i].removeAt(7);
//   }

//   for (int i = 0; i < parsedList.length; i++) {
//     var price = Random().nextInt(50).toDouble();
//     var sku = i + 100;
//     Product product = Product(parsedList[i][6]);
//     product.setDescription(
//         'lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam at magna in velit egestas tristique sit  vel est.');
//     product.setGender(parsedList[i][0]);
//     product.setCategory(parsedList[i][1]);
//     product.setSubCategory(parsedList[i][2]);
//     product.setType(parsedList[i][3]);
//     product.setColor(parsedList[i][4]);
//     product.setUsage(parsedList[i][5]);
//     product.setImageUrl(parsedList[i][7]);
//     product.setPrice(price);
//     product.setSku(sku);

//     await productRepository.registerProduct(product);
//   }

//   return AlertDialog(
//     content: Text(
//       translate('OK'),
//       textAlign: TextAlign.center,
//     ),
//   );
// }
