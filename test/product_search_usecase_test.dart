import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/search_product_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';

import 'Repositories_test/sqflite_ffi_product_repository_impl.dart';

void main() {
  group('Product Search Usecase', () {
    test('user can search a product', () async {
      var productRepository = SqfliteFfiProductRepostitoryImpl();
      Product product = Product("iphone X");
      await productRepository.init();
      await productRepository.registerProduct(product);

      SearchProductUsecase searchProductUsecase =
          SearchProductUsecase(productRepository);

      var searchedProduct =
          await searchProductUsecase.searchProduct("iphone X");

      expect(searchedProduct.runtimeType, Product);
      expect(await searchedProduct.getTitle(), product.getTitle());
    });
  });
}
