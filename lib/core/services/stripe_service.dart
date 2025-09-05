import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_gateway_testing/Features/payment/data/models/stripe/customer_payment_info_model/customer_payment_info_model.dart';
import 'package:payment_gateway_testing/Features/payment/data/models/stripe/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:payment_gateway_testing/Features/payment/data/models/stripe/payment_intent_model/payment_intent_model.dart';
import 'package:payment_gateway_testing/Features/payment/domain/requests/create_customer_request.dart';
import 'package:payment_gateway_testing/Features/payment/domain/requests/init_payment_sheet_request.dart';
import 'package:payment_gateway_testing/core/constants/api_endpoints.dart';
import 'package:payment_gateway_testing/core/constants/api_keys.dart';
import 'package:payment_gateway_testing/core/services/api_service.dart';
import '../../Features/payment/domain/requests/create_payment_intent_request.dart';

class StripService {
  final ApiService apiService = ApiService();

  Future<CustomerPaymentInfoModel> createCustomer({
    required CreateCustomerRequest request,
  }) async {
    final response = await apiService.post(
      url: APIEndPoints.createCustomerPayment,
      contentType: Headers.formUrlEncodedContentType,
      token: APIKeys.stripeSecretKey,
      body: request.toJson(),
    );

    final customerModel = CustomerPaymentInfoModel.fromJson(response.data);
    return customerModel;
  }

  Future<PaymentIntentModel> _createPaymentIntent({
    required CreatePaymentIntentRequest request,
  }) async {
    final response = await apiService.post(
      url: APIEndPoints.createPaymentIntent,
      token: APIKeys.stripeSecretKey,
      contentType: Headers.formUrlEncodedContentType,
      body: request.toJson(),
    );
    final paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  Future<EphemeralKeyModel> _createEphemeralKeys({
    required String customerId,
  }) async {
    final response = await apiService.post(
      url: APIEndPoints.createEphemeralKeys,
      headers: {
        'Authorization': "Bearer ${APIKeys.stripeSecretKey}",
        'Stripe-Version': '2025-08-27.basil',
      },
      contentType: Headers.formUrlEncodedContentType,
      body: {'customer': customerId},
    );
    final ephemeralKey = EphemeralKeyModel.fromJson(response.data);
    return ephemeralKey;
  }

  Future<void> _initPaymentSheet({
    required InitPaymentSheetRequest request,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        merchantDisplayName: request.displayName,
        paymentIntentClientSecret: request.paymentIntentClientSecret,
        customerEphemeralKeySecret: request.customerEphemeralKeySecret,
        customerId: request.customerId,
      ),
    );
  }

  Future<void> _presentPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future<void> makePayment({
    required CreatePaymentIntentRequest request,
  }) async {
    var paymentIntent = await _createPaymentIntent(request: request);
    var ephemeralKey = await _createEphemeralKeys(
      customerId: request.customerId,
    );
    await _initPaymentSheet(
      request: InitPaymentSheetRequest(
        displayName: 'Jafar Marouf',
        paymentIntentClientSecret: paymentIntent.clientSecret!,
        customerEphemeralKeySecret: ephemeralKey.secret,
        customerId: paymentIntent.customer,
      ),
    );
    await _presentPaymentSheet();
  }
}
