import 'package:mobile_ecommerce/Domain/Repositories_abstractions/product_repository.dart';

class Search_Product_Usecase {
  ProductRepository productRepository;

  Search_Product_Usecase(this.productRepository);

  searchProductsByTitle(String productTitle) async {
    var productList =
        await productRepository.retrieveProductsByTitle(productTitle);

    return await productList;
  }

  search_products_with_filters(Map filters) async {
    var productList =
        await productRepository.search_products_with_filters(filters);

    return await productList;
  }
}
