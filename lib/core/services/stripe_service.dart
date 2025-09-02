import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_gateway_testing/Features/payment/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:payment_gateway_testing/core/constants/api_endpoints.dart';
import 'package:payment_gateway_testing/core/constants/api_keys.dart';
import 'package:payment_gateway_testing/core/services/api_service.dart';

import '../../Features/payment/domain/requests/create_payment_intent_request.dart';

class StripService {
  final ApiService apiService = ApiService();

  Future<PaymentIntentModel> createPaymentIntent({
    required CreatePaymentIntentRequest request,
  }) async {
    final response = await apiService.post(
      url: ApiEndPoints.createPaymentIntent,
      token: APIKeys.stripeSecretKey,
      contentType: Headers.formUrlEncodedContentType,
      body: {'amount': request.amount, 'currency': request.currency},
    );
    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  Future<void> initPaymentSheet({
    required String paymentIntentClientSecret,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        merchantDisplayName: 'Jafar Marouf',
        paymentIntentClientSecret: paymentIntentClientSecret,
      ),
    );
  }

  Future<void> presentPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future<void> makePayment({
    required CreatePaymentIntentRequest request,
  }) async {
    var paymentIntent = await createPaymentIntent(request: request);
    await initPaymentSheet(
      paymentIntentClientSecret: paymentIntent.clientSecret!,
    );
    await presentPaymentSheet();
  }
}
