import 'package:mobile_ecommerce/Domain/Repositories_abstractions/product_repository.dart';

class SearchProductUsecase {
  ProductRepository productRepository;

  SearchProductUsecase(this.productRepository);

  searchProductsByTitle(String productTitle) async {
    await productRepository.init();
    var productList =
        await productRepository.retrieveProductsByTitle(productTitle);
    await productRepository.close();

    return await productList;
  }
}
