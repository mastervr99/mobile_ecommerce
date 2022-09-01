abstract class ProductRepository {
  _init_database();

  retrieveProductsByTitle(String productTitle);

  retrieve_product_with_sku(int sku);

  _close_database();
}
