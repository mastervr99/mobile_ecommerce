import 'package:mobile_ecommerce/Domain/Repositories_abstractions/product_repository.dart';

class Search_Product_Usecase {
  ProductRepository productRepository;

  Search_Product_Usecase(this.productRepository);

  searchProductsByTitle(String productTitle) async {
    var productList =
        await productRepository.retrieveProductsByTitle(productTitle);

    return await productList;
  }
}
