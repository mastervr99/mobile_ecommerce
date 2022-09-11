abstract class ProductRepository {
  _init_database();

  retrieveProductsByTitle(String productTitle);

  retrieve_product_with_sku(int sku);

  search_products_with_filters(Map filters);

  _close_database();
}
