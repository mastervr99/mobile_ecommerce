abstract class ProductRepository {
  _init_database();

  retrieveProductsByTitle(String productTitle);

  _close_database();
}
