import 'package:mobile_ecommerce/Domain/Entity/address.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/address_repository.dart';

class Update_An_Address_Usecase {
  Address_Repository address_repository;

  Update_An_Address_Usecase(this.address_repository);

  update_user_address(Address address) async {
    await address_repository.update_user_address(address);
  }
}
