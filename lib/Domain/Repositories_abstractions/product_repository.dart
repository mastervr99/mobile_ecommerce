import 'package:mobile_ecommerce/Domain/Entity/product.dart';

abstract class ProductRepository {
  init();

  retrieveSingleProductByTitle(String productTitle);

  retrieveProductsByTitle(String productTitle);

  close();
}
