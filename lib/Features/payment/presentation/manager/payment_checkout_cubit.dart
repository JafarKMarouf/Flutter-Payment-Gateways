import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:payment_gateway_testing/Features/payment/domain/repos/payment_checkout_repo.dart';
import 'package:payment_gateway_testing/Features/payment/domain/requests/create_payment_intent_request.dart';

part 'payment_checkout_state.dart';

class PaymentCheckoutCubit extends Cubit<PaymentCheckoutState> {
  final PaymentCheckoutRepo paymentCheckoutRepo;

  PaymentCheckoutCubit(this.paymentCheckoutRepo)
    : super(PaymentCheckoutInitial());

  Future<void> makePayment({
    required CreatePaymentIntentRequest request,
  }) async {
    emit(PaymentCheckoutLoading());
    var result = await paymentCheckoutRepo.makePayment(request: request);

    result.fold(
      (fail) {
        emit(PaymentCheckoutFailure(fail.errMessage));
      },
      (success) {
        emit(PaymentCheckoutSuccess());
      },
    );
  }

  @override
  void onChange(Change<PaymentCheckoutState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
