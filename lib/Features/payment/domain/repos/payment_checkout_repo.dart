import 'package:dartz/dartz.dart';
import 'package:payment_gateway_testing/Features/payment/data/models/stripe/customer_payment_info_model/customer_payment_info_model.dart';
import 'package:payment_gateway_testing/Features/payment/domain/requests/create_customer_request.dart';
import 'package:payment_gateway_testing/Features/payment/domain/requests/create_payment_intent_request.dart';
import 'package:payment_gateway_testing/core/errors/failure.dart';

abstract class PaymentCheckoutRepo {
  Future<Either<Failure, CustomerPaymentInfoModel>> createCustomer({
    required CreateCustomerRequest request,
  });

  Future<Either<Failure, void>> makePayment({
    required CreatePaymentIntentRequest request,
  });
}
