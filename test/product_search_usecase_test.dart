import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/search_product_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'Repositories_test/product_repository_sqflite_ffi_impl.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  group('Product Search Usecase', () {
    test('user can search a product', () async {
      var productRepository = ProductRepostitorySqfliteFfiImpl();
      await productRepository.init();
      Product product = Product("iphone X");
      await productRepository.registerProduct(product);

      SearchProductUsecase searchProductUsecase =
          SearchProductUsecase(productRepository);

      var searchedProduct =
          await searchProductUsecase.searchSingleProductByTitle("iphone X");

      expect(searchedProduct.runtimeType, Product);
      expect(await searchedProduct.getTitle(), product.getTitle());
    });

    test('search result return multiple products', () async {
      var productRepository = ProductRepostitorySqfliteFfiImpl();
      await productRepository.init();

      Product product = Product("iphone 12 red");
      Product product2 = Product("iphone 12 blue");
      Product product3 = Product("iphone 12 green");
      Product product4 = Product("iphone 12 yellow");
      Product product5 = Product("iphone 12 black");
      await productRepository.registerProduct(product);
      await productRepository.registerProduct(product2);
      await productRepository.registerProduct(product3);
      await productRepository.registerProduct(product4);
      await productRepository.registerProduct(product5);

      SearchProductUsecase searchProductUsecase =
          SearchProductUsecase(productRepository);

      var products =
          await searchProductUsecase.searchProductsByTitle("iphone 12");

      int numberOfProducts = products.length;
      expect(numberOfProducts, 5);
    });

    test('create database from csv', () async {
      var productRepository = ProductRepostitorySqfliteFfiImpl();
      await productRepository.init();

      TestWidgetsFlutterBinding.ensureInitialized();

      final _rawData =
          await rootBundle.loadString("assets/csv_database/fashion.csv");
      //List<List<dynamic>> data = const CsvToListConverter().convert(_rawData);

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

      //expect(parsedList[0], true);

      for (int i = 0; i < parsedList.length; i++) {
        Product product = Product(parsedList[i][6]);
        product.setDescription(
            'lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam at magna in velit egestas tristique sit amet vel est.');
        product.setGender(parsedList[i][0]);
        product.setCategory(parsedList[i][1]);
        product.setSubCategory(parsedList[i][2]);
        product.setType(parsedList[i][3]);
        product.setColor(parsedList[i][4]);
        product.setUsage(parsedList[i][5]);
        product.setImageUrl(parsedList[i][7]);

        await productRepository.registerProduct(product);
      }

      SearchProductUsecase searchProductUsecase =
          SearchProductUsecase(productRepository);

      var searchedProduct =
          await searchProductUsecase.searchSingleProductByTitle("Gini");
      expect(searchedProduct.runtimeType, Product);
      expect(await searchedProduct.getTitle(),
          'Gini and Jony Girls Knit White Top');
    });
  });
}
