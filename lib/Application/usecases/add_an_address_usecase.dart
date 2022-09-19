import 'package:mobile_ecommerce/Domain/Entity/address.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/address_repository.dart';

class Add_An_Address_Usecase {
  Address_Repository address_repository;

  Add_An_Address_Usecase(this.address_repository);

  register_user_address(Address address) async {
    await address_repository.register_user_address(address);
  }
}
