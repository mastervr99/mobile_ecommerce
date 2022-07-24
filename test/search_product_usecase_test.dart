import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/search_product_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'Repositories_test/product_repository_sqflite_ffi_impl.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
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

//     await productRepository.registerProduct(product);
//   }

//   return AlertDialog(
//     content: Text(
//       translate('OK'),
//       textAlign: TextAlign.center,
//     ),
//   );
// }
  group('Search Product Usecase', () {
    test('search results can return multiple products', () async {
      var productRepository = ProductRepostitorySqfliteFfiImpl();
      await productRepository.init();

      Product product = Product("nokia 12");
      Product product2 = Product("nokia 11");

      await productRepository.registerProduct(product);
      await productRepository.registerProduct(product2);

      SearchProductUsecase searchProductUsecase =
          SearchProductUsecase(productRepository);

      var products = await searchProductUsecase.searchProductsByTitle("nokia");

      expect(await products[0].getTitle(), "nokia 12");
      expect(await products[1].getTitle(), "nokia 11");

      var productsNotFound =
          await searchProductUsecase.searchProductsByTitle("lumia");

      expect(await productsNotFound.isEmpty, true);
    });

    test('create database from csv', () async {
      var productRepository = ProductRepostitorySqfliteFfiImpl();
      await productRepository.init();

      TestWidgetsFlutterBinding.ensureInitialized();

      final _rawData =
          await rootBundle.loadString("assets/csv_database/fashion.csv");

      var encoded = utf8.encode(_rawData);
      var decoded = utf8.decode(encoded);
      var rowAsListValues =
          const CsvToListConverter(fieldDelimiter: ',', eol: '\n')
              .convert(decoded);
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
        product.setPrice(0.01);
        product.setSku(100 + i);
        // expect(product.toMap(), 'setting 2 from csv');

        await productRepository.registerProduct(product);
      }

      SearchProductUsecase searchProductUsecase =
          SearchProductUsecase(productRepository);

      // // ***********************************************
      // var productsTest =
      //     await productRepository.retrieveProductsForTest('gini');

      // List<Product> searchedProducts = [];

      // productsTest.forEach((productData) {
      //   Product product = Product(productData['title'] ?? '');
      //   product.setDescription(productData['description'] ?? '');
      //   product.setGender(productData['gender'] ?? '');
      //   product.setCategory(productData['category'] ?? '');
      //   product.setSubCategory(productData['subCategory'] ?? '');
      //   product.setType(productData['type'] ?? '');
      //   product.setColor(productData['color'] ?? '');
      //   product.setUsage(productData['usage'] ?? '');
      //   product.setImageUrl(productData['imageUrl'] ?? '');

      //   searchedProducts.add(product);
      // });

      // // expect(searchedProducts[0].toMap(), true);

      // // ***********************************************

      var searchedProduct =
          await searchProductUsecase.searchProductsByTitle("Gini");
      expect(await searchedProduct[0].getTitle(),
          'Gini and Jony Girls Knit White Top');

      // expect(await searchedProduct[0].toMap(), 'searchedProduct color');

      expect(await searchedProduct[0].getImageUrl(),
          'http://assets.myntassets.com/v1/images/style/properties/f3964f76c78edd85f4512d98b26d52e9_images.jpg');
    });

    test('Search with multiple words', () async {
      var productRepository = ProductRepostitorySqfliteFfiImpl();
      await productRepository.init();

      Product product = Product("samsung 10 red");
      Product product2 = Product("samsung 12 blue");

      await productRepository.registerProduct(product);
      await productRepository.registerProduct(product2);

      SearchProductUsecase searchProductUsecase =
          SearchProductUsecase(productRepository);

      var searchResults =
          await searchProductUsecase.searchProductsByTitle("samsung 12");

      expect(await searchResults[0].getTitle(), "samsung 10 red");
      expect(await searchResults[1].getTitle(), "samsung 12 blue");
    });

    test('search return product with all searchs terms in title', () async {
      var productRepository = ProductRepostitorySqfliteFfiImpl();
      await productRepository.init();

      Product product = Product("lg 10 red");
      Product product2 = Product("lg 12 blue");

      await productRepository.registerProduct(product);
      await productRepository.registerProduct(product2);

      SearchProductUsecase searchProductUsecase =
          SearchProductUsecase(productRepository);

      var searchResults =
          await searchProductUsecase.searchProductsByTitle("lg 10");

      var value = "lg 10";
      var searchTerms = value.split(' ');
      var foundCorrectProducts = [];

      await searchResults.forEach((product) {
        var productTitle = product.getTitle();

        bool containsAll = true;

        searchTerms.forEach((searchTerm) {
          if (!productTitle.contains(searchTerm)) {
            containsAll = false;
          }
        });

        if (containsAll) {
          foundCorrectProducts.add(product);
        }
      });

      Product productTest = foundCorrectProducts[0];

      expect(productTest.getTitle(), "lg 10 red");
    });
  });
}
