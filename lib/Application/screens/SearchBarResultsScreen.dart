import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mobile_ecommerce/Application/common_widgets/AppBarWidget.dart';
import 'package:mobile_ecommerce/Application/common_widgets/GridTilesProducts.dart';
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
  String searchTerms = 'test';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: Column(
        children: <Widget>[
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
          FutureBuilder(
            future: findProducts(searchTerms),
            builder: (context, AsyncSnapshot snapshot) {
              List<Product>? productsList = snapshot.data;

              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                      child: Text('Check your internet connection!!'));
                case ConnectionState.waiting:
                  return Center(child: Text('Loading ...'));
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else
                    // return Expanded(
                    //   child: ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: snapshot.data.length,
                    //     itemBuilder: (context, index) {
                    //       return ListTile(
                    //         title: Text('${snapshot.data[index].getImageUrl()}'),
                    //       );
                    //     },
                    //   ),
                    // );
                    //List<Results>? results = values.results;
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
                            slug: '',
                            price: '0,01',
                          ));
                        }),
                      ),
                    );
              }
            },
          ),
        ],
      ),
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
