import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/common_widgets/AppBarWidget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/BottomNavBarWidget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/GridTilesProducts.dart';
import 'package:mobile_ecommerce/Application/usecases/search_product_usecase.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/product_repository_sqflite_impl.dart';

class SearchBarResultsScreen extends StatefulWidget {
  var searchTerms;

  SearchBarResultsScreen({Key? key, this.searchTerms}) : super(key: key);

  @override
  _SearchBarResultsScreenState createState() =>
      _SearchBarResultsScreenState(searchTerms: searchTerms);
}

class _SearchBarResultsScreenState extends State<SearchBarResultsScreen> {
  var searchTerms;

  _SearchBarResultsScreenState({this.searchTerms});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: Column(
        children: <Widget>[
          //**************** TO REMOVE **************** */
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //       textStyle: const TextStyle(fontSize: 20)),
          //   onPressed: () async {
          //     await createProductTable();
          //   },
          //   child: const Text('Enabled'),
          // ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Theme(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
          ),
          if (searchTerms.isNotEmpty)
            FutureBuilder(
              future: findProducts(searchTerms),
              builder: (context, AsyncSnapshot snapshot) {
                List<dynamic>? productsList = snapshot.data;

                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                        child: Text('Check your internet connection!!'));
                  case ConnectionState.waiting:
                    return Center(child: Text('Loading ...'));
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else if (productsList!.isEmpty)
                      return Center(
                        child: Text(translate('label_product_search_failed')),
                      );
                    else
                      return Expanded(
                        child: GridView.count(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          crossAxisCount: 2,
//    physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(1.0),
                          childAspectRatio: 8.0 / 12.0,
                          children: List<Widget>.generate(productsList!.length,
                              (index) {
                            return GridTile(
                                child: GridTilesProducts(
                              name: productsList[index]!.getTitle(),
                              imageUrl: productsList[index]!.getImageUrl(),
                              product: productsList[index]!,
                              price: productsList[index]!.getPrice().toString(),
                            ));
                          }),
                        ),
                      );
                }
              },
            ),
        ],
      ),
      bottomNavigationBar: BottomNavBarWidget(),
    );
  }
}

findProducts(var value) async {
  var productRepository = ProductRepostitorySqfliteImpl();
  await productRepository.init();

  SearchProductUsecase searchProductUsecase =
      SearchProductUsecase(productRepository);

  var searchedProducts =
      await searchProductUsecase.searchProductsByTitle(value);

  return await searchedProducts;
}

//**************** TO REMOVE **************** */
// createProductTable() async {
//   var productRepository = ProductRepostitorySqfliteImpl();
//   await productRepository.init();

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
//     product.setPrice(0.01);
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
