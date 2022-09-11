import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/search_product_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'Repositories_test/product_repository_sqflite_ffi_impl.dart';

void main() {
  closeSqfliteFfiDatabase() async {
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await db.close();
  }

  group('Search Product Usecase', () {
    test('search results can return multiple products', () async {
      var productRepository = ProductRepostitorySqfliteFfiImpl();

      Product product = Product("nokia 12");
      Product product2 = Product("nokia 11");

      await productRepository.registerProduct(product);
      await productRepository.registerProduct(product2);

      Search_Product_Usecase search_product_usecase =
          Search_Product_Usecase(productRepository);

      var products =
          await search_product_usecase.searchProductsByTitle("nokia");

      expect(await products[0].getTitle(), "nokia 12");
      expect(await products[1].getTitle(), "nokia 11");

      var productsNotFound =
          await search_product_usecase.searchProductsByTitle("lumia");

      expect(await productsNotFound.isEmpty, true);

      await closeSqfliteFfiDatabase();
    });

    test('create database from csv', () async {
      var productRepository = ProductRepostitorySqfliteFfiImpl();

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

        await productRepository.registerProduct(product);
      }

      Search_Product_Usecase search_product_usecase =
          Search_Product_Usecase(productRepository);

      var searchedProduct =
          await search_product_usecase.searchProductsByTitle("Gini");
      expect(await searchedProduct[0].getTitle(),
          'Gini and Jony Girls Knit White Top');

      expect(await searchedProduct[0].getImageUrl(),
          'http://assets.myntassets.com/v1/images/style/properties/f3964f76c78edd85f4512d98b26d52e9_images.jpg');

      await closeSqfliteFfiDatabase();
    });

    test('Search with multiple words', () async {
      var productRepository = ProductRepostitorySqfliteFfiImpl();

      Product product = Product("samsung 10 red");
      Product product2 = Product("samsung 12 blue");

      await productRepository.registerProduct(product);
      await productRepository.registerProduct(product2);

      Search_Product_Usecase search_product_usecase =
          Search_Product_Usecase(productRepository);

      var searchResults =
          await search_product_usecase.searchProductsByTitle("samsung 12");

      expect(await searchResults[0].getTitle(), "samsung 10 red");
      expect(await searchResults[1].getTitle(), "samsung 12 blue");

      await closeSqfliteFfiDatabase();
    });

    test('search return product with all searchs terms in title', () async {
      var productRepository = ProductRepostitorySqfliteFfiImpl();

      Product product = Product("lg 10 red");
      Product product2 = Product("lg 12 blue");

      await productRepository.registerProduct(product);
      await productRepository.registerProduct(product2);

      Search_Product_Usecase search_product_usecase =
          Search_Product_Usecase(productRepository);

      var searchResults =
          await search_product_usecase.searchProductsByTitle("lg 10");

      var value = "lg 10";
      var searchTerms = value.split(' ');
      var foundCorrectProducts = [];

      await searchResults.forEach((product) {
        var productTitle = product.getTitle();

        bool containsAll = false;

        searchTerms.forEach((searchTerm) {
          if (productTitle.contains(searchTerm)) {
            containsAll = true;
          }
        });

        if (containsAll) {
          foundCorrectProducts.add(product);
        }
      });

      Product productTest = foundCorrectProducts[0];

      expect(productTest.getTitle(), "lg 10 red");

      await closeSqfliteFfiDatabase();
    });

    test('search products with filters', () async {
      var productRepository = ProductRepostitorySqfliteFfiImpl();

      Product product = Product("lg 10");
      product.setCategory('smartphone');

      Product product2 = Product("lg Pad");
      product2.setCategory('tablet');
      product2.setPrice(250);

      await productRepository.registerProduct(product);
      await productRepository.registerProduct(product2);

      Search_Product_Usecase search_product_usecase =
          Search_Product_Usecase(productRepository);

      var filters = {'category': 'tablet', 'price': 250};

      var products_searched_with_filters =
          await search_product_usecase.search_products_with_filters(filters);

      var first_product_found = await products_searched_with_filters[0];

      expect(await first_product_found.getTitle(), "lg Pad");

      await closeSqfliteFfiDatabase();
    });
  });
}
