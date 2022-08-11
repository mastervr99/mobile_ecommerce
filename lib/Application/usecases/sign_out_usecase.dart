import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';

class SignOutUsecase {
  ConnectedUserRepository connectedUserRepository;

  SignOutUsecase(this.connectedUserRepository);

  disconnectUser() async {
    await connectedUserRepository.removeConnectedUser();
  }
}
