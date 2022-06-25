import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/product_repository.dart';

class SearchProductUsecase {
  ProductRepository productRepository;

  SearchProductUsecase(this.productRepository);

  searchProduct(String productTitle) async {
    await productRepository.init();
    var product = await productRepository.retrieveProduct(productTitle);
    await productRepository.close();

    return await product;
  }
}
