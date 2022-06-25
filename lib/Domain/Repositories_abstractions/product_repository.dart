import 'package:mobile_ecommerce/Domain/Entity/product.dart';

abstract class ProductRepository {
  init();

  registerProduct(Product product);

  retrieveSingleProductByTitle(String productTitle);

  retrieveProductsByTitle(String productTitle);

  close();
}
