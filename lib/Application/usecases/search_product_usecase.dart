import 'package:mobile_ecommerce/Domain/Repositories_abstractions/product_repository.dart';

class SearchProductUsecase {
  ProductRepository productRepository;

  SearchProductUsecase(this.productRepository);

  searchSingleProductByTitle(String productTitle) async {
    await productRepository.init();
    var product =
        await productRepository.retrieveSingleProductByTitle(productTitle);
    await productRepository.close();

    return await product;
  }

  searchProductsByTitle(String productTitle) async {
    await productRepository.init();
    var product = await productRepository.retrieveProductsByTitle(productTitle);
    await productRepository.close();

    return await product;
  }
}
