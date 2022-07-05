import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/common_widgets/AppBarWidget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/SearchWidget.dart';
import 'package:mobile_ecommerce/Application/usecases/search_product_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/product_repository_sqflite_impl.dart';

class SearchBarResultsScreen extends StatefulWidget {
  @override
  _SearchBarResultsScreenState createState() => _SearchBarResultsScreenState();
}

class _SearchBarResultsScreenState extends State<SearchBarResultsScreen> {
  _SearchBarResultsScreenState();

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20)),
            onPressed: () async {
              await showProduct(context, 'Test button');
            },
            child: const Text('Enabled'),
          ),
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
                  onSubmitted: (value) => {showProduct(context, value)},
                ),
                data: Theme.of(context).copyWith(
                  primaryColor: Colors.grey[600],
                ),
              ),
            ),
          ),
          TestWidget(context)
        ],
      ),
    );
  }
}

Widget TestWidget(BuildContext context) {
  final Future<String> _myNetworkData = Future<String>.delayed(
    const Duration(seconds: 4),
    () => 'This is what you have been waiting for',
  );

  return FutureBuilder(
      // future: searchedProducts,
      builder: (context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return Center(child: Text('Check your internet connection!!'));
      case ConnectionState.waiting:
        return Center(child: Text('Loading ...'));
      default:
        if (snapshot.hasError)
          return Text('Error: ${snapshot.error}');
        else
          return Text('OK');
    }
  });
}

createProductTable() async {
  var productRepository = ProductRepostitorySqfliteImpl();
  await productRepository.init();

  WidgetsFlutterBinding.ensureInitialized();

  final _rawData =
      await rootBundle.loadString("assets/csv_database/fashion.csv");

  var encoded = utf8.encode(_rawData);
  var decoded = utf8.decode(encoded);
  var rowAsListValues =
      const CsvToListConverter(fieldDelimiter: ',', eol: '\n').convert(decoded);
  var parsedList = [];

  for (var items in rowAsListValues) {
    parsedList.add(items);
  }

  parsedList.removeAt(0);

  for (int i = 0; i < parsedList.length; i++) {
    parsedList[i].removeAt(0);
    parsedList[i].removeAt(7);
  }

  for (int i = 0; i < parsedList.length; i++) {
    Product product = Product(parsedList[i][6]);
    product.setDescription(
        'lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam at magna in velit egestas tristique sit  vel est.');
    product.setGender(parsedList[i][0]);
    product.setCategory(parsedList[i][1]);
    product.setSubCategory(parsedList[i][2]);
    product.setType(parsedList[i][3]);
    product.setColor(parsedList[i][4]);
    product.setUsage(parsedList[i][5]);
    product.setImageUrl(parsedList[i][7]);

    await productRepository.registerProduct(product);
  }

  return AlertDialog(
    content: Text(
      translate('OK'),
      textAlign: TextAlign.center,
    ),
  );
}

showProduct(BuildContext context, var value) async {
  var productRepository = ProductRepostitorySqfliteImpl();
  await productRepository.init();

  SearchProductUsecase searchProductUsecase =
      SearchProductUsecase(productRepository);

  var searchedProduct =
      await searchProductUsecase.searchSingleProductByTitle(value);

  var searchedProductTitle = await searchedProduct.getTitle();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        // Retrieve the text the that user has entered by using the
        // TextEditingController.
        content: Text(
          searchedProductTitle,
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}
