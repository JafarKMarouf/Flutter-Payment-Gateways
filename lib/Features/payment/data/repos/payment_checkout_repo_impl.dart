import 'package:dartz/dartz.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_gateway_testing/Features/payment/data/models/customer_payment_info_model/customer_payment_info_model.dart';
import 'package:payment_gateway_testing/Features/payment/domain/repos/payment_checkout_repo.dart';
import 'package:payment_gateway_testing/Features/payment/domain/requests/create_customer_request.dart';
import 'package:payment_gateway_testing/Features/payment/domain/requests/create_payment_intent_request.dart';
import 'package:payment_gateway_testing/core/errors/failure.dart';
import 'package:payment_gateway_testing/core/services/stripe_service.dart';

class PaymentCheckoutRepoImpl extends PaymentCheckoutRepo {
  final stripService = StripService();

  @override
  Future<Either<Failure, void>> makePayment({
    required CreatePaymentIntentRequest request,
  }) async {
    try {
      await stripService.makePayment(request: request);
      return right(null);
    } on StripeException catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CustomerPaymentInfoModel>> createCustomer({
    required CreateCustomerRequest request,
  }) async {
    try {
      var customer = await stripService.createCustomer(request: request);
      return right(customer);
    } on StripeException catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
