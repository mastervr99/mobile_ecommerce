import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/search_product_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';

import 'Repositories_test/product_repository_sqflite_ffi_impl.dart';

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
  });
}
