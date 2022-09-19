import 'package:mobile_ecommerce/Domain/Entity/address.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/address_repository.dart';

class Delete_An_Address_Usecase {
  Address_Repository address_repository;

  Delete_An_Address_Usecase(this.address_repository);

  remove_user_address(Address address) async {
    await address_repository.remove_user_address(address);
  }
}
