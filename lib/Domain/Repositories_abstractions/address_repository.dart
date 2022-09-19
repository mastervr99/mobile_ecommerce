import 'package:mobile_ecommerce/Domain/Entity/address.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';

abstract class Address_Repository {
  _init_database();

  get_database();

  register_user_address(Address address);

  update_user_address(Address address);

  retrieve_user_addresses(User user);

  remove_user_address(Address address);

  _close_database();
}
