import 'package:dartz/dartz.dart';
import 'package:payment_gateway_testing/Features/payment/domain/requests/create_payment_intent_request.dart';
import 'package:payment_gateway_testing/core/errors/failure.dart';

abstract class PaymentCheckoutRepo {
  Future<Either<Failure, void>> makePayment({
    required CreatePaymentIntentRequest request,
  });
}
