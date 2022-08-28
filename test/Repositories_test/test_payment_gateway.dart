import 'package:mobile_ecommerce/Domain/Repositories_abstractions/payment_gateway.dart';

class Test_Payment_Gateway extends Payment_Gateway {
  String payment_status = 'success';

  makePayment() {
    //NO IMPLEMENTATION FOR TEST
  }

  @override
  getPaymentStatus() {
    return payment_status;
  }
}
