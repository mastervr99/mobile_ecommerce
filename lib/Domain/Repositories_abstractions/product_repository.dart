import 'package:mobile_ecommerce/Domain/Entity/product.dart';

abstract class ProductRepository {
  init();

  registerProduct(Product product);

  retrieveProduct(String productTitle);

  close();
}
