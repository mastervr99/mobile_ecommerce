abstract class ProductRepository {
  init();

  retrieveProductsByTitle(String productTitle);

  close();
}
