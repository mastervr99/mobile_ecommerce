import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_ecommerce/Application/screens/Orders_History_Screen.dart';
import 'package:mobile_ecommerce/.env.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/payment_gateway.dart';

class Stripe_Payment_Controller extends GetxController
    implements Payment_Gateway {
  Map<String, dynamic>? paymentIntentData;
  bool is_payment_valid = false;

  Future<void> makePayment(
      {required BuildContext context,
      required String amount,
      required String currency}) async {
    try {
      var paymentIntentData = await _createPaymentIntent(amount, currency);
      if (await paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            applePay: PaymentSheetApplePay(merchantCountryCode: currency),
            googlePay: PaymentSheetGooglePay(merchantCountryCode: currency),
            merchantDisplayName: 'Prospects',
            customerId: paymentIntentData!['customer'],
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
          ),
        );
        await _displayPaymentSheet(context);
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  _displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Get.snackbar('Payment', 'Payment Successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));
      is_payment_valid = true;
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  _createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': _calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ${stripePrivateKey}',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  _calculateAmount(String amount) {
    final a = (double.parse(amount)).ceil() * 100;
    return a.toString();
  }

  @override
  check_if_payment_valid() {
    return is_payment_valid;
  }
}
